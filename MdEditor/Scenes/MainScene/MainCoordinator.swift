//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 28.04.2023.
//

import UIKit

/// Протокол координатора главного экрана
protocol IMainCoordinator: ICoordinator {
	/// Стартует сценарий файл менеджера
	func showFileManagerFlow()
	/// Стартует сценарий экрана "AboutApp"
	func showAboutAppFlow()
}

/// Координатор главного экрана
class MainCoordinator: IMainCoordinator {

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

	/// Запуск и отображения главного экрана
	func start() {
		let mainViewController = MainAssembler.assembly(coordinator: self)
		navigationController.setViewControllers([mainViewController], animated: false)
	}

	/// Стартует сценарий файл менеджера
	func showFileManagerFlow() {
		let fileManagerCoordinator = FileManagerCoordinator(navigationController: navigationController)
		childCoordinators.append(fileManagerCoordinator)
		fileManagerCoordinator.start()
	}

	/// Стартует сценарий экрана "AboutApp"
	func showAboutAppFlow() {
		let aboutAppCordintaor = AboutAppCoordinator(navigationController: self.navigationController)
		childCoordinators.append(aboutAppCordintaor)
		aboutAppCordintaor.start()
	}
}
