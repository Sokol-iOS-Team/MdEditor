//
//  PreviewMarkdownInteractor.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 31.05.2023.
//

import Foundation

/// Протокол для реализации бизнес логики просмотра превью файла
protocol IPreviewMarkdownInteractor: AnyObject {
	func fetchData()
}

/// Класс для реализации бизнес логики просмотра превью файла
final class PreviewMarkdownInteractor: IPreviewMarkdownInteractor {

	// MARK: - Dependencies

	private let presenter: IPreviewMarkdownPresenter
	private let coordinator: IEditFileCoordinator

	private let currentURL: URL?

	// MARK: - Lifecycle

	/// Метод инициализации PreviewMarkdownInteractor
	/// - Parameters:
	///   - presenter: presenter подписанный на протокол IPreviewMarkdownPresenter
	///   - coordinator: coordinator одписанный на протокол IEditFileCoordinator
	///   - currentURL: url для получения файла
	init(presenter: IPreviewMarkdownPresenter, coordinator: IEditFileCoordinator, currentURL: URL?) {
		self.presenter = presenter
		self.coordinator = coordinator
		self.currentURL = currentURL
	}

	// MARK: - Internal Methods

	/// Метод для получения текста по ссылке и его дальнейшей отправки
	func fetchData() {
		guard let currentURL else { return }
		let response = PreviewMarkdownModel.Responce(url: currentURL)
		presenter.present(response: response)
	}

}
