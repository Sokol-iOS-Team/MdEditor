//
//  AboutAppInteractor.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 26.04.2023.
//

import UIKit

/// Протокол релизации бизнес-логики экрана "О приложении"
protocol IAboutAppInteractor {
	/// Метод для запроса данных
	func fetchData()
	/// Метод для закрытия экрана
	func close()
}

final class AboutAppInteractor: IAboutAppInteractor {

	// MARK: - Dependencies

	private var presenter: IAboutAppPresenter
	private var mdFileManager: IMdFileManager
	private var coordinator: IAboutAppCoordinator

	// MARK: - Lifecycle

	/// Метод инициализации AboutAppInteractor
	/// - Parameter presenter: presenter подписанный на протокол IAboutPresenter
	/// - Parameter mdFileManager: mdFileManager подписанный на протокол IMdFileManager
	/// - Parameter coordinator: coordinator подписанный на протокол IAppCoordinator
	init(presenter: IAboutAppPresenter, mdFileManager: IMdFileManager, coordinator: IAboutAppCoordinator) {
		self.presenter = presenter
		self.mdFileManager = mdFileManager
		self.coordinator = coordinator
	}

	// MARK: - Internal Methods

	func fetchData() {
		let fileName = "About"
		guard let fileUrl = mdFileManager.getFileUrlByName(
			folderName: .rootFolder,
			fileName: fileName,
			fileExtension: .markDown
		) else {
			fatalError("Файл About.md не сушествует")
		}
		presenter.present(response: AboutAppModel.Response(url: fileUrl))
	}

	func close() {
		coordinator.finish()
	}
}
