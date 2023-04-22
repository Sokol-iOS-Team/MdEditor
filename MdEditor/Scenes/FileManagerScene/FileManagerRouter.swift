//
//  FileManagerRouter.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 22.04.2023.
//

import UIKit

/// Протокол для переходов с экрана файлового менеджера
protocol IFileManagerRouter {
	func openFileManager(with file: FileManagerModel.ViewModel.File, router: IFileManagerRouter?)
}

/// Класс для реализации переходов с экрана файлового менеджера
class FileManagerRouter: IFileManagerRouter {

	// MARK: - Private Properties

	private let fileManagerViewController: UIViewController

	// MARK: - Lifecycle

	/// Метод инициализации FileManagerRouter
	/// - Parameters:
	///   - mainViewController: Вью контроллер экрана fileManagerViewController
	init(fileManagerViewController: UIViewController) {
		self.fileManagerViewController = fileManagerViewController
	}

	// MARK: - Internal Methods

	/// Метод для перехода на новый экран фалового менеджера
	func openFileManager(with file: FileManagerModel.ViewModel.File, router: IFileManagerRouter?) {
		if let newFileManagerViewController = FileManagerAssembler.assembly() as? FileManagerViewController {
			newFileManagerViewController.currentFile = file
			newFileManagerViewController.router = router
			fileManagerViewController.navigationController?.pushViewController(newFileManagerViewController, animated: true)
		}
	}
}
