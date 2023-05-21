//
//  EditFileViewController.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 05.05.2023.
//

import UIKit
import WebKit

/// Протокол для отображения данных на экране редактирования файла
protocol IEditFileViewController: AnyObject {
	func render(viewModel: EditFileModel.ViewModel)
}

/// Класс для отображения данных на экране редактирования файла
final class EditFileViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IEditFileInteractor?

	// MARK: - Private Properties

	private var webView: WKWebView!

	// MARK: - Lifecycle

	override func loadView() {
		webView = WKWebView()
		view = webView
	}

	override func viewDidLoad() {
		navigationItem.leftBarButtonItem = makeCloseBarButtonItem()

		interactor?.fetchData()
	}

	// MARK: - Private

	private func makeWebView() -> WKWebView {
		let webView = WKWebView()

		return webView
	}

	private func makeCloseBarButtonItem() -> UIBarButtonItem {
		let closeButton = UIBarButtonItem(
			image: UIImage(systemName: "xmark"),
			style: .done,
			target: self,
			action: #selector(didTouchUpInsideCloseButton(_:))
		)

		return closeButton
	}

	// MARK: - Actions

	@objc private func didTouchUpInsideCloseButton(_ button: UIBarButtonItem) {
		interactor?.closeFile()
	}
}

extension EditFileViewController: IEditFileViewController {
	/// Метод для отображения данных на главном экране
	/// - Parameter viewModel: принимает EditFileModel.ViewModel в качестве параметра
	func render(viewModel: EditFileModel.ViewModel) {
		webView.loadHTMLString(viewModel.text, baseURL: nil)
		title = viewModel.title
	}
}
