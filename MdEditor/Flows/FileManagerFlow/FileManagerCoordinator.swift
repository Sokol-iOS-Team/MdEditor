//
//  FileManagerCoordinator.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 28.04.2023.
//

import UIKit

protocol IFileManagerCoordinator: ICoordinator {
	func openFolder(at url: URL)
}

class FileManagerCoordinator: IFileManagerCoordinator {

	// MARK: - Dependencies

	var navigationController: UINavigationController

	// MARK: - Internal Properties

	weak var finishDelegate: ICoordinatorFinishDelegate?

	var childCoordinators: [ICoordinator] = [ICoordinator]()

	// MARK: - Lifecycle

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	// MARK: - Internal Methods

	/// Запуск и отображения файл менеджера с корненовой директории
	func start() {
		let fileManagerViewController = FileManagerAssembler.assembly(coordinator: self, currentURL: nil)
		navigationController.pushViewController(fileManagerViewController, animated: true)
	}

	/// Открытие директории  файл менеджера по ссылке
	func openFolder(at url: URL) {
		let fileManagerViewController = FileManagerAssembler.assembly(coordinator: self, currentURL: url)
		navigationController.pushViewController(fileManagerViewController, animated: true)
	}

}
