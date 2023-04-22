//
//  FileManagerPresenter.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 20.04.2023.
//

import Foundation

/// Протокол для подготовки отображения данных на экране файлового менеджера
protocol IFileManagerPresenter {
	func present(response: FileManagerModel.Response)
}

/// Класс для реализации подготовки отображения данных на экране файлового менеджера
final class FileManagerPresenter: IFileManagerPresenter {

	// MARK: - Dependencies

	private weak var viewController: IFileManagerViewController?
	private var attrWorker: IFileManagerAttrWorker

	// MARK: - Lifecycle

	/// Метод инициализации FileManagerPresenter
	/// - Parameters:
	///   - viewController: viewController подписанный на протокол IFileManagerViewController
	///   - attrWorker: attrWorker подписанный на протокол IFileManagerAttrWorker
	init(viewController: IFileManagerViewController, attrWorker: IFileManagerAttrWorker) {
		self.viewController = viewController
		self.attrWorker = attrWorker
	}

	// MARK: - Internal Methods

	/// Метод для подготовки отображения данных и передачи их viewController
	/// - Parameter response: Содержит модель массива файлов, полученных из файлового менеджера
	func present(response: FileManagerModel.Response) {
		let section = FileManagerModel.ViewModel.Section(files: mapFilesData(files: response.data.files))

		let viewData = FileManagerModel.ViewModel(filesBySection: section)

		viewController?.render(viewData: viewData)
	}

	// MARK: - Private Methods

	private func mapFilesData(files: [File]) -> [FileManagerModel.ViewModel.File] {
		attrWorker.getViewModelFiles(with: files)
	}
}
