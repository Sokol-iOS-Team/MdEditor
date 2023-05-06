//
//  EditFileAssembler.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 05.05.2023.
//

import UIKit

final class EditFileAssembler {

	/// Метод для создания экрана редактирования файла и зависимостей его VIP цикла
	/// - Parameters:
	///   - coordinator: coordinator подписанный на протокол IEditFileCoordinator
	///   - currentURL: url файла
	/// - Returns: Возвращает EditFileViewController для отображения экрана редактирования файла
	static func assembly(coordinator: IEditFileCoordinator, currentURL: URL?) -> UIViewController {
		let editFileViewController = EditFileViewController()
		let mdFileManager = MdFileManager()
		let editFilePresenter = EditFilePresenter(viewControler: editFileViewController)
		let editFileInteractor = EditFileInteractor(
			presenter: editFilePresenter,
			mdFileManager: mdFileManager,
			coordinator: coordinator,
			currentURL: currentURL
		)
		editFileViewController.interactor = editFileInteractor

		return editFileViewController
	}
}
