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

	private weak var viewControler: EditFileViewController?

	// MARK: - Lifecycle

	/// Метод инициализации EditFilePresenter
	/// - Parameter viewControler: viewControler подписанный на протокол IEditFileViewController
	init(viewControler: EditFileViewController) {
		self.viewControler = viewControler
	}

	// MARK: - Internal Methods

	/// Метод для подготовки отображения данных и передачи их viewController
	func present(response: EditFileModel.Response) {
		let viewModel = EditFileModel.ViewModel(text: response.text)
		viewControler?.render(viewModel: viewModel)
	}
}
