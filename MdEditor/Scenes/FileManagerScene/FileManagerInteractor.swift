//
//  FileManagerInteractor.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 20.04.2023.
//

import Foundation

/// Протокол для реализации бизнес логики файлового менеджера
protocol IFileManagerInteractor {
	func fetchData(request: FileManagerModel.Request.FileURL)
}

/// Класс для реализации бизнес логики файлового менеджера
final class FileManagerInteractor: IFileManagerInteractor {

	// MARK: - Dependencies

	private var presenter: IFileManagerPresenter
	private var fileProviderAdapter: IFileProviderAdapter

	// MARK: - Lifecycle

	/// Метод инициализации FileManagerInteractor
	/// - Parameters:
	///   - presenter: presenter подписанный на протокол IFileManagerPresenter
	///   - fileProviderAdapter: fileProviderAdapter подписанный на протокол IFileManagerFileProviderAdapter
	init(presenter: IFileManagerPresenter, fileProviderAdapter: IFileProviderAdapter) {
		self.fileProviderAdapter = fileProviderAdapter
		self.presenter = presenter
	}

	// MARK: - Internal Methods

	/// Метод получения файлов и их отправки для подготовки отображения
	/// - Parameter request: Содержит url, который нужен для получения информации о файлах/папках
	func fetchData(request: FileManagerModel.Request.FileURL) {
		var files = [File]()

		if let url = request.url {
			files = fileProviderAdapter.scan(with: url)
		} else {
			files = fileProviderAdapter.getRootFolders()
		}

		let responseData = FileManagerModel.Response.Section(files: files)
		let response = FileManagerModel.Response(data: responseData)

		presenter.present(response: response)
	}
}
