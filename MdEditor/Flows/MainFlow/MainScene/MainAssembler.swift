//
//  MainAssembler.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

/// Класс для создания главного экрана
class MainAssembler {

	// MARK: - Internal Methods

	/// Метод для создания главного экрана и зависимостей его VIP цикла
	/// - Returns: Возвращает MainViewController для отображения главного экрана
	/// - Parameter coordinator: coordinator подписанный на протокол IMainCoordinator
	static func assembly(coordinator: IMainCoordinator) -> UIViewController {
		let mainViewController = MainViewController()
		let mdFileManager = MdFileManager()

		let mainPresenter = MainPresenter(viewController: mainViewController)
		let mainInteractor = MainInteractor(
			presenter: mainPresenter,
			mdFileManager: mdFileManager,
			coordinator: coordinator
		)
		mainViewController.interactor = mainInteractor

		return mainViewController
	}
}
