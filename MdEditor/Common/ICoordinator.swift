//
//  ICoordinator.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 28.04.2023.
//

import UIKit

/// Протокол завершения работы координатора
protocol ICoordinatorFinishDelegate: AnyObject {
	/// - Parameter coordinator: Протокол `ICoordinator`.
	func didFinish(_ coordinator: ICoordinator)
}

/// Протокол координатора
protocol ICoordinator: AnyObject {
	/// Делегат завершения работы координатора
	var finishDelegate: ICoordinatorFinishDelegate? { get set }

	/// Навигационный контроллер для отображения 
	var navigationController: UINavigationController { get set }

	/// Дочерние координаторы
	var childCoordinators: [ICoordinator] { get set }

	/// Метод для запуска сценария (flow)
	func start(_ flow: Flow?)

	/// Метод для заверешния сценария (flow)
	func finish()
}

extension ICoordinator {
	/// Реализация метода завершения по-умолчанию
	func finish() {
		childCoordinators.removeAll()
		finishDelegate?.didFinish(self)
	}
}
