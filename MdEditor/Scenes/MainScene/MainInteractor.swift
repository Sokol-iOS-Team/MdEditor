//
//  MainInteractor.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import Foundation

/// Протокол для реализации бизнес логики главного экрана
protocol IMainInteractor {
	func fetchData()
	func createFile(request: MainModel.NewFile.Request)
}

/// Класс для реализации бизнес логики главного экрана
class MainInteractor: IMainInteractor {

	// MARK: - Dependencies

	private let presenter: IMainPresenter
	private var fileProviderAdapter: IFileProviderAdapter

	// MARK: - Lifecycle

	/// Метод инициализации MainInteractor
	/// - Parameter presenter: presenter подписанный на протокол IMainPresenter
	init(presenter: IMainPresenter, fileProviderAdapter: IFileProviderAdapter) {
		self.fileProviderAdapter = fileProviderAdapter
		self.presenter = presenter
	}

	// MARK: - Internal Methods

	/// Метод получения элементов меню и их отправки для подготовки отображения
	func fetchData() {
		let menuItems = MenuBuilder().getMenuItems()

		presenter.present(response: MainModel.FetchMenu.Response(menuItems: menuItems))
	}
	/// Метод по созданию файла
	func createFile(request: MainModel.NewFile.Request) {
		do {
			try fileProviderAdapter.createFile(withName: request.name)
		} catch CreateFileErrors.fileExist {
			let response = MainModel.NewFile.Response.failure(
				title: "Error",
				message: "File with the same name already exists."
			)
			presenter.provideAlertInfo(response: response)
			return
		} catch {}
		let response = MainModel.NewFile.Response.success
		presenter.provideAlertInfo(response: response)
	}
}
