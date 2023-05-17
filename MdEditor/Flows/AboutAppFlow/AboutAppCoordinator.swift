//
//  AboutAppCordinator.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 05.05.2023.
//

import UIKit

protocol IAboutAppCoordinator: ICoordinator {

}

class AboutAppCoordinator: IAboutAppCoordinator {

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

	/// Запуск и отображения экрана "О приложении"
	func start() {
		let aboutAppViewController = AboutAppAssembler.assembly(coordinator: self)
		navigationController.pushViewController(aboutAppViewController, animated: true)
	}
}
