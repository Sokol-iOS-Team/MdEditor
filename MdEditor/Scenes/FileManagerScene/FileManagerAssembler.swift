//
//  FileManagerAssembler.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 20.04.2023.
//

import UIKit

/// Класс для создания экрана файлового менеджера
final class FileManagerAssembler {

	// MARK: - Internal Methods

	/// Метод для создания экрана файлового менеджера и зависимостей его VIP цикла
	/// - Returns: Возвращает FileManagerViewController для отображения экрана файлового менеджера
	static func assembly() -> UIViewController {
		let fileManagerViewController = FileManagerViewController()
		let fileProviderAdapter = FileManagerFileProviderAdapter(fileProvider: FileProvider())
		let attrWorker = FileManagerAttrWorker()
		let fileManagerPresenter = FileManagerPresenter(viewController: fileManagerViewController, attrWorker: attrWorker)
		let filetManagerInteractor = FileManagerInteractor(
			presenter: fileManagerPresenter,
			fileProviderAdapter: fileProviderAdapter
		)
		fileManagerViewController.interactor = filetManagerInteractor

		return fileManagerViewController
	}
}
