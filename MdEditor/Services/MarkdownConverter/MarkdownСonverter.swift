//
//  MarkdownСonverter.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 26.04.2023.
//

import UIKit
import PDFKit

/// Протокол MarkdownСonverter.
protocol IMarkdownСonverter {
	func convertMDToHTML(markdownText: String) -> String
	func convertMDToAttributedTextConverter(markdownText: String) -> NSMutableAttributedString
	func convertMDToPDF(markdownText: String, pdfAuthor: String, pdfTitle: String) -> Data
}

/// Методы класса MarkdownСonverter осушествляют конвертацию текста с разметкой MarkDown в код HTML страницы.
final class MarkdownСonverter: IMarkdownСonverter {

	// MARK: - Public properties

	private let lexer = Markdown.Lexer()
	private let parser = Markdown.Parser()
	private var mdFileManager: IMdFileManager

	// MARK: - Lifecycle

	init(mdFileManager: IMdFileManager) {
		self.mdFileManager = mdFileManager
	}

	// MARK: - Public methods

	func convertMDToHTML(markdownText: String) -> String {
		let tokens = lexer.tokenize(markdownText)
		let document = parser.parse(tokens: tokens)

		let visitor = HtmlVisitor()
		let html = document.accept(visitor: visitor)

		return makeHtml(html.joined())
	}

	func convertMDToAttributedTextConverter(markdownText: String) -> NSMutableAttributedString {
		let tokens = lexer.tokenize(markdownText)
		let document = parser.parse(tokens: tokens)

		return convert(document: document)
	}

	func convertMDToPDF(markdownText: String, pdfAuthor: String, pdfTitle: String) -> Data {
		let tokens = lexer.tokenize(markdownText)
		let document = parser.parse(tokens: tokens)

		let visitor = AttribitedTextVisitor()
		let lines = document.accept(visitor: visitor)

		let pdfMetaData  = [
			kCGPDFContextAuthor: pdfAuthor,
			kCGPDFContextTitle: pdfTitle
		]

		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]

		let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
		let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

		let data = graphicsRenderer.pdfData { context in
			context.beginPage()

			var cursor: CGFloat = 40

			lines.forEach { line in
				cursor = context.addAttributedText(
					text: line,
					indent: 24.0,
					cursor: cursor,
					pdfSize: pageRect.size
				)
				cursor += 24
			}
		}
		return data
	}
	// MARK: - Private methods

	private func convert(document: Document) -> NSMutableAttributedString {
		let visitor = AttribitedTextVisitor()

		let result = document.accept(visitor: visitor)
		return result.joined()
	}

	/// Метод оборачивает текст в базовый ситаксес html разметки и подключает CSS файл со стилями.
	/// - Parameter text: текст с разметкой html.
	/// - Returns: html код готовый к отоброжению в WebView.
	private func makeHtml(_ text: String) -> String {
		let ccsFileName = "style"
		guard let cssURL = mdFileManager.getFileUrlByName(
			folderName: .rootFolder,
			fileName: ccsFileName,
			fileExtension: .css
		) else { return " "}
		guard let cssString = try? String(contentsOf: cssURL) else { return " "}

		return "<!DOCTYPE html><html><head><style>\(cssString)</style></head><boby><div class=\"mdViewer\">\(text)</div></boby></html>" // swiftlint:disable:this line_length
	}
}
