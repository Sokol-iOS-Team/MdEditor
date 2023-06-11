//
//  AuthorizationCoordinator.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import UIKit

/// Протокол координатора экрана авторизации.
protocol IAuthorizationCoordinator: ICoordinator {
	func showAuthorizationScene()
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

	/// Запуск и отображения сцены авторизации ё
	func start(_ flow: Flow? = nil) {
		showAuthorizationScene()
	}

	/// Стартует сценарий файл менеджера
	func showAuthorizationScene() {
		let authorizationViewController = AuthorizationAssembler.assembly(coordinator: self)
		navigationController.setViewControllers([authorizationViewController], animated: false)
	}
}
