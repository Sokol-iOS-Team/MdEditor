//
//  AboutAppAssembler.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 01.05.2023.
//

import UIKit

/// Класс для создания главного экрана
class AboutAppAssembler {

	// MARK: - Internal Methods

	/// Метод для создания главного экрана и зависимостей его VIP цикла
	/// - Returns: Возвращает AboutAppViewController для отображения главного экрана
	static func assembly(coordinator: IAboutAppCoordinator) -> UIViewController {
		let aboutAppViewController = AboutAppViewController()
		let mdFileManager = MdFileManager()
		let markdownConverter = MarkdownСonverter(markdownParser: MarkdownParser(), mdFileManager: mdFileManager)

		let aboutAppPresenter = AboutAppPresenter(
			viewController: aboutAppViewController,
			markdownConverter: markdownConverter
		)
		let aboutAppInteractor = AboutAppInteractor(
			presenter: aboutAppPresenter,
			mdFileManager: mdFileManager
		)
		aboutAppViewController.interactor = aboutAppInteractor

		return aboutAppViewController
	}
}
