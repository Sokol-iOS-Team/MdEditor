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

	private let smallIndent: CGFloat = 8
	private let mediumIndent: CGFloat = 16

	// MARK: - Private Properties

	private lazy var pdfView = makePDFView()
	private var viewModel = PreviewMarkdownModel.ViewModel(data: Data())

	// MARK: - Lifecycle

	override func loadView() {
		view = pdfView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.rightBarButtonItems = [makePrintBarButtonItem(), makeShareBarButtonItem()]

		interactor?.fetchData()
	}

	// MARK: - Private Methods

	private func makePDFView() -> PDFView {
		let pdfView = PDFView()
		pdfView.autoScales = true
		pdfView.pageBreakMargins = UIEdgeInsets(
			top: smallIndent,
			left: mediumIndent,
			bottom: smallIndent,
			right: mediumIndent
		)

		return pdfView
	}

	private func makePrintBarButtonItem() -> UIBarButtonItem {
		let previewButton = UIBarButtonItem(
			image: UIImage(systemName: "printer"),
			style: .done,
			target: self,
			action: #selector(didTouchUpInsidePrintButton(_:))
		)

		return previewButton
	}

	private func makeShareBarButtonItem() -> UIBarButtonItem {
		let previewButton = UIBarButtonItem(
			image: UIImage(systemName: "square.and.arrow.up"),
			style: .done,
			target: self,
			action: #selector(didTouchUpInsideShareButton(_:))
		)

		return previewButton
	}

	// MARK: - Actions

	@objc private func didTouchUpInsidePrintButton(_ button: UIBarButtonItem) {
		let printInteractionController = UIPrintInteractionController.shared
		printInteractionController.printingItem = viewModel.data
		printInteractionController.present(animated: true)
	}

	@objc private func didTouchUpInsideShareButton(_ button: UIBarButtonItem) {
		let activityViewController = UIActivityViewController(
			activityItems: [viewModel.data],
			applicationActivities: nil
		)

		present(activityViewController, animated: true, completion: nil)
	}

}

extension PreviewMarkdownViewController: IPreviewMarkdownViewController {
	/// Метод для отображения данных на экране превью
	/// - Parameter viewModel: принимает PreviewMarkdownModel.ViewModel в качестве параметра
	func render(viewModel: PreviewMarkdownModel.ViewModel) {
		self.viewModel = viewModel
		pdfView.document = PDFDocument(data: viewModel.data)
	}
}
