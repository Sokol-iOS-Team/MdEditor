//
//  MainRouter.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

/// Протокол для переходов с главного экрана
protocol IMainRouter {
	func routeFileManager()
}

/// Класс для реализации переходов с главного экрана
class MainRouter: IMainRouter {

	// MARK: - Dependencies

	private weak var mainViewController: UIViewController?
	private let fileManagerViewController: UIViewController

	// MARK: - Lifecycle

	/// Метод инициализации MainRouter
	/// - Parameters:
	///   - mainViewController: Вью контроллер экрана mainViewController
	///   - fileManagerViewController: Вью контроллер экрана fileManagerViewController
	init(mainViewController: UIViewController, fileManagerViewController: UIViewController) {
		self.mainViewController = mainViewController
		self.fileManagerViewController = fileManagerViewController
	}

	// MARK: - Internal Methods

	/// Метод для перехода на экран файлового менеджера
	func routeFileManager() {
		mainViewController?.navigationController?.pushViewController(fileManagerViewController, animated: true)
	}
}
