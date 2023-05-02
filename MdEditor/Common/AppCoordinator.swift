//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Dmitry Troshkin  on 28.04.2023.
//

import UIKit

/// Протокол координатора приложения
protocol IAppCoordinator: ICoordinator {
	/// Стартует сценарий главного экрана
	func showMainFlow()
}

/// Координатор приложения
final class AppCoordinator: IAppCoordinator {

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

	func start() {
		showMainFlow()
	}

	/// Метод для старта сценария главного экрана
	func showMainFlow() {
		let mainCoordinator = MainCoordinator(navigationController: navigationController)
		childCoordinators.append(mainCoordinator)
		mainCoordinator.start()
	}
}
