//
//  AuthorizationCoordinator.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import UIKit

/// Протокол координатора экрана авторизации.
protocol IAuthorizationCoordinator: ICoordinator {
	func showAuthorizationFlow()
	func showMainFlow()
}

/// Координатор экрана авторизации.
class AuthorizationCoordinator: IAuthorizationCoordinator {

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

	/// Запуск и отображения сцены авторизации.
	func start(_ flow: Flow? = nil) {
		showAuthorizationFlow()
	}

	/// Стартует сценарий сцены авторизации.
	func showAuthorizationFlow() {
		let authorizationViewController = AuthorizationAssembler.assembly(coordinator: self)
		navigationController.setViewControllers([authorizationViewController], animated: false)
	}

	/// Стартует сценарий главной сцены.
	func showMainFlow() {
		let mainCoordinator = MainCoordinator(navigationController: navigationController)
		mainCoordinator.finishDelegate = self
		childCoordinators.append(mainCoordinator)
		mainCoordinator.start(.main)
	}
}

extension AuthorizationCoordinator: ICoordinatorFinishDelegate {
	func didFinish(_ coordinator: ICoordinator) {
		if let mainCoordinator = coordinator as? MainCoordinator {
			if let index = childCoordinators.firstIndex(where: { $0 === mainCoordinator }) {
				childCoordinators.remove(at: index)
			}
		}
	}
}
