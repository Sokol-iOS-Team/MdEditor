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
	private var mdFileManager: IMdFileManager
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
		mdFileManager: IMdFileManager,
		coordinator: IEditFileCoordinator,
		currentURL: URL?
	) {
		self.presenter = presenter
		self.mdFileManager = mdFileManager
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
		guard let htmlText = makeHTMLtext() else { return }
		let response = EditFileModel.Response(text: htmlText)
		presenter.present(response: response)
	}

	// MARK: - Private

	private func makeHTMLtext() -> String? {
		guard let text = getFileText(from: currentURL) else { return nil }

		return "<!DOCTYPE html><html><head><style> body {font-size: 300%;}</style></head><boby>\(text)</boby></html>"
	}

	private func getFileText(from url: URL?) -> String? {
		guard
			let currentURL = currentURL,
			let fileText = try? String(contentsOf: currentURL)
		else { return nil }

		return fileText
	}
}
