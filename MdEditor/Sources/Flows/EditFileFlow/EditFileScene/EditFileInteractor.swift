//
//  EditFileInteractor.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 05.05.2023.
//

import Foundation

/// Протокол для реализации бизнес логики редактирования файла
protocol IEditFileInteractor: AnyObject {
	func fetchData()
	func closeFile()
}

/// Класс для реализации бизнес логики редактирования файла
final class EditFileInteractor: IEditFileInteractor {

	// MARK: - Dependencies

	private var presenter: IEditFilePresenter
	private var coordinator: IEditFileCoordinator

	private var currentURL: URL?

	// MARK: - Lifecycle

	/// Метод инициализации EditFileInteractor
	/// - Parameters:
	///   - presenter: presenter подписанный на протокол IEditFilePresenter
	///   - mdFileManager: mdFileManager подписанный на протокол IMdFileManager
	///   - coordinator: coordinator одписанный на протокол IEditFileCoordinator
	///   - currentURL: url для получения файла
	init(
		presenter: IEditFilePresenter,
		coordinator: IEditFileCoordinator,
		currentURL: URL?
	) {
		self.presenter = presenter
		self.coordinator = coordinator
		self.currentURL = currentURL
	}

	// MARK: - Internal Methods

	/// Метод закрытия файла
	func closeFile() {
		coordinator.finish()
	}

	/// Метод для получения текста по ссылке и его дальнейшей отправки
	func fetchData() {
		guard let currentURL = currentURL else { return }
		let response = EditFileModel.Response(url: currentURL)
		presenter.present(response: response)
	}
}
