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
	static func assembly() -> UIViewController {
		let mainViewController = MainViewController()
		let fileProviderAdapter = FileProviderAdapter(fileProvider: FileProvider())

		let mainPresenter = MainPresenter(viewController: mainViewController)
		let mainInteractor = MainInteractor(presenter: mainPresenter, fileProviderAdapter: fileProviderAdapter)
		mainViewController.interactor = mainInteractor

		return mainViewController
	}
}
