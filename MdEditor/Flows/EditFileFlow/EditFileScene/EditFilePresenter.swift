//
//  EditFilePresenter.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 05.05.2023.
//

import UIKit

/// Протокол для подготовки отображения данных на экране редактирования файла
protocol IEditFilePresenter {
	func present(response: EditFileModel.Response)
}

/// Класс для подготовки отображения данных на экране редактирования файла
final class EditFilePresenter: IEditFilePresenter {

	// MARK: - Dependencies

	private weak var viewController: IEditFileViewController?
	private var markdownConverter: IMarkdownСonverter

	// MARK: - Lifecycle

	/// Метод инициализации EditFilePresenter
	/// - Parameter viewControler: viewControler подписанный на протокол IEditFileViewController
	init(viewController: IEditFileViewController, markdownConverter: IMarkdownСonverter) {
		self.viewController = viewController
		self.markdownConverter = markdownConverter
	}

	// MARK: - Internal Methods

	/// Метод для подготовки отображения данных и передачи их viewController
	func present(response: EditFileModel.Response) {
		guard let mdString = try? String(contentsOf: response.url) else { fatalError("Some error") }
		let htmlString = markdownConverter.convertMDtoHTML(text: mdString)
		let title = response.url.deletingPathExtension().lastPathComponent
		let viewModel = EditFileModel.ViewModel(title: title, text: htmlString)
		viewController?.render(viewModel: viewModel)
	}
}
