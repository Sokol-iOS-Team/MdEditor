//
//  AppCoordinator.swift
//  MdEditor
//
//  Created by Dmitry Troshkin  on 28.04.2023.
//

import UIKit

enum Flow {
	/// Навигация по документам и работа с ними.
	case authorization
	/// Стартовый экран для отображения списка документов и меню.
	case main
}

/// Протокол координатора приложения
protocol IAppCoordinator: ICoordinator {
	/// Стартует сценарий авторизации
	func showAuthorizationFlow()
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

	func start(_ flow: Flow? = nil) {
		switch flow {
		case .authorization:
			showAuthorizationFlow()
		case .main:
			showMainFlow()
		case .none:
			showAuthorizationFlow()
		}
	}

	/// Метод для старта сценария авторизации
	func showAuthorizationFlow() {
		let authorizationCoordinator = AuthorizationCoordinator(navigationController: navigationController)
		authorizationCoordinator.finishDelegate = self
		childCoordinators.append(authorizationCoordinator)
		authorizationCoordinator.start()
	}

	/// Метод для старта сценария главного экрана
	func showMainFlow() {
		let mainCoordinator = MainCoordinator(navigationController: navigationController)
		childCoordinators.append(mainCoordinator)
		mainCoordinator.start()
	}
}

// MARK: - ICoordinatorFinishDelegate

extension AppCoordinator: ICoordinatorFinishDelegate {
	func didFinish(_ coordinator: ICoordinator) {
		if coordinator is IAuthorizationCoordinator {
			childCoordinators.removeAll { $0 === coordinator }
			showMainFlow()
		}
	}
}
