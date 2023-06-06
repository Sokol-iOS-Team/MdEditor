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
	func showFilePreview()
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

	/// Метод для получения текста по ссылке и его дальнейшей отправки
	func fetchData() {
		guard let currentURL = currentURL else { return }
		let response = EditFileModel.Response(url: currentURL)
		presenter.present(response: response)
	}

	/// Метод закрытия файла
	func closeFile() {
		coordinator.finish()
	}

	/// Метод открытия экрана просмотра превью файла в PDF
	func showFilePreview() {
		coordinator.showFilePreview()
	}
}
