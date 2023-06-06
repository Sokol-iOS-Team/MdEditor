//
//  PreviewMarkdownPresenter.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 31.05.2023.
//

import UIKit

/// Протокол для подготовки отображения данных на экране просмотра превью файла
protocol IPreviewMarkdownPresenter: AnyObject {
	func present(response: PreviewMarkdownModel.Responce)
}

/// Класс для подготовки отображения данных на экране просмотра превью файла
final class PreviewMarkdownPresenter: IPreviewMarkdownPresenter {

	// MARK: - Dependencies

	private weak var viewController: IPreviewMarkdownViewController?
	private var markdownConverter: IMarkdownСonverter

	// MARK: - Lifecycle

	/// Метод инициализации EditFilePresenter
	/// - Parameter viewControler: viewControler подписанный на протокол IEditFileViewController
	init(viewController: IPreviewMarkdownViewController, markdownConverter: IMarkdownСonverter) {
		self.viewController = viewController
		self.markdownConverter = markdownConverter
	}

	// MARK: - Internal Methods

	/// Метод для получения текста, его обработки и дальнейшей передачи во ViewController
	func present(response: PreviewMarkdownModel.Responce) {
		guard let mdString = try? String(contentsOf: response.url) else { fatalError("Some error") }
		let data = markdownConverter.convertMDToPDF(markdownText: mdString, pdfAuthor: "", pdfTitle: "")
		let viewModel = PreviewMarkdownModel.ViewModel(data: data)
		viewController?.render(viewModel: viewModel)
	}

}
