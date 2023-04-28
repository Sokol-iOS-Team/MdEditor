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
	/// - Parameters:
	///   - coordinator: coordinator подписанный на протокол IFileManagerCoordinator
	///   - currentURL: url текущей директории файл менеджера
	static func assembly(coordinator: IFileManagerCoordinator, currentURL: URL?) -> UIViewController {
		let fileManagerViewController = FileManagerViewController()
		let fileProviderAdapter = FileProviderAdapter(fileProvider: FileProvider())
		let fileManagerPresenter = FileManagerPresenter(viewController: fileManagerViewController)
		let filetManagerInteractor = FileManagerInteractor(
			presenter: fileManagerPresenter,
			fileProviderAdapter: fileProviderAdapter,
			coordinator: coordinator,
			currentURL: currentURL
		)
		fileManagerViewController.interactor = filetManagerInteractor

		return fileManagerViewController
	}
}
