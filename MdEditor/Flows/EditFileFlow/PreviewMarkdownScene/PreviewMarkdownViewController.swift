//
//  PreviewMarkdownViewController.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 31.05.2023.
//

import UIKit
import PDFKit

/// Протокол для отображения данных на экране просмотра превью файла
protocol IPreviewMarkdownViewController: AnyObject {
	func render(viewModel: PreviewMarkdownModel.ViewModel)
}

/// Класс для отображения данных на экране просмотра превью файла
final class PreviewMarkdownViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IPreviewMarkdownInteractor?

	// MARK: - Constants

	// MARK: - Private Properties

	private lazy var pdfView = makePDFView()

	// MARK: - Lifecycle

	override func loadView() {
		view = pdfView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		interactor?.fetchData()
	}

	// MARK: - Private Methods

	private func makePDFView() -> PDFView {
		let pdfView = PDFView()
		pdfView.autoScales = true
		pdfView.pageBreakMargins = UIEdgeInsets(
			top: 8,
			left: 16,
			bottom: 8,
			right: 16
		)

		return pdfView
	}
}

extension PreviewMarkdownViewController: IPreviewMarkdownViewController {
	func render(viewModel: PreviewMarkdownModel.ViewModel) {
		pdfView.document = PDFDocument(data: viewModel.data)
	}
}
