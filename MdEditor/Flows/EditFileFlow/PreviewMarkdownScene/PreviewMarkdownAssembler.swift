//
//  PreviewMarkdownAssembler.swift
//  MdEditor
//
//  Created by Dmitry Trоshkin on 31.05.2023.
//

import UIKit

final class PreviewMarkdownAssembler {

	// MARK: - Internal Methods

	/// Метод для создания экрана просмотра превью файла и зависимостей его VIP цикла
	/// - Parameters:
	///   - coordinator: coordinator подписанный на протокол IEditFileCoordinator
	///   - currentURL: url файла
	/// - Returns: Возвращает PreviewMarkdownViewController для отображения экрана просмотра превью файла
	static func assembly(coordinator: IEditFileCoordinator, currentURL: URL?) -> UIViewController {
		let previewMarkdownViewController = PreviewMarkdownViewController()

		let mdFileManager = MdFileManager()
		let markdownConverter = MarkdownСonverter(mdFileManager: mdFileManager)

		let previewMarkdownPresenter = PreviewMarkdownPresenter(
			viewController: previewMarkdownViewController,
			markdownConverter: markdownConverter
		)

		let previewMarkdownInteractor = PreviewMarkdownInteractor(
			presenter: previewMarkdownPresenter,
			coordinator: coordinator,
			currentURL: currentURL
		)

		previewMarkdownViewController.interactor = previewMarkdownInteractor

		return previewMarkdownViewController
	}
}
