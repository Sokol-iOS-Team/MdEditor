//
//  FileManagerInteractor.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 20.04.2023.
//

import Foundation

/// Протокол для реализации бизнес логики файлового менеджера
protocol IFileManagerInteractor {
	func fetchData()
	func openFile(_ file: FileManagerModel.Request.File)
}

/// Класс для реализации бизнес логики файлового менеджера
final class FileManagerInteractor: IFileManagerInteractor {

	// MARK: - Dependencies

	private var presenter: IFileManagerPresenter
	private var mdFileManager: IMdFileManager
	private var coordinator: IFileManagerCoordinator

	private var currentURL: URL?

	// MARK: - Lifecycle

	/// Метод инициализации FileManagerInteractor
	/// - Parameters:
	///   - presenter: presenter подписанный на протокол IFileManagerPresenter
	///   - mdFileManager: mdFileManager подписанный на протокол IMdFileManager
	///   - coordinator: coordinator одписанный на протокол IFileManagerCoordinator
	///   - currentURL: url для получения файлов
	init(
		presenter: IFileManagerPresenter,
		mdFileManager: IMdFileManager,
		coordinator: IFileManagerCoordinator,
		currentURL: URL?
	) {
		self.presenter = presenter
		self.mdFileManager = mdFileManager
		self.coordinator = coordinator
		self.currentURL = currentURL
	}

	// MARK: - Internal Methods

	/// Метод получения файлов и их отправки для подготовки отображения
	func fetchData() {
		var files = [File]()

		if let currentURL = currentURL {
			files = mdFileManager.scanFolder(with: currentURL)
		} else {
			files = mdFileManager.getRootFolders()
		}

		let responseData = FileManagerModel.Response.Section(files: files)
		let response = FileManagerModel.Response(data: responseData, currentURL: currentURL)

		presenter.present(response: response)
	}

	/// Метод открытия файла или папки
	/// - Parameter file: Файл типа FileManagerModel.Request.File//
	func openFile(_ file: FileManagerModel.Request.File) {
		switch file.type {
		case .file:
			coordinator.openFile(at: file.url)
		case .folder:
			coordinator.openFolder(at: file.url)
		}
	}
}
