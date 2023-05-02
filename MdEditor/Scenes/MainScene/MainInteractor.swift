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
	func openFileManager()
	func createFile(request: MainModel.NewFile.Request)
}

/// Класс для реализации бизнес логики главного экрана
class MainInteractor: IMainInteractor {

	// MARK: - Dependencies

	private let presenter: IMainPresenter
	private var fileProviderAdapter: IFileProviderAdapter
	private let coordinator: IMainCoordinator

	// MARK: - Lifecycle

	/// Метод инициализации MainInteractor
	/// - Parameter presenter: presenter подписанный на протокол IMainPresenter
	/// - Parameter fileProviderAdapter: FileProviderAdapter подписанный на протокол IFileProviderAdapter
	/// - Parameter coordinator: coordinator подписанный на протокол IMainCoordinator
	init(
		presenter: IMainPresenter,
		fileProviderAdapter: IFileProviderAdapter,
		coordinator: IMainCoordinator
	) {
		self.presenter = presenter
		self.fileProviderAdapter = fileProviderAdapter
		self.coordinator = coordinator
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
				title: L10n.Main.Interactor.ErrorResponse.FileExist.title,
				message: L10n.Main.Interactor.ErrorResponse.FileExist.message
			)
			presenter.provideAlertInfo(response: response)
			return
		} catch {}
		let response = MainModel.NewFile.Response.success
		presenter.provideAlertInfo(response: response)
	}

	/// Метод открытия файл менеджера
	func openFileManager() {
		coordinator.showFileManagerFlow()
	}
}
