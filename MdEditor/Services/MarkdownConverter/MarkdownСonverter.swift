//
//  MarkdownСonverter.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 26.04.2023.
//

import UIKit

/// Протокол MarkdownСonverter.
protocol IMarkdownСonverter {
	func convertMDtoHTML(text: String) -> String
}

/// Методы класса MarkdownСonverter осушествляют конвертацию текста с разметкой MarkDown в код HTML страницы.
final class MarkdownСonverter: IMarkdownСonverter {

	// MARK: - Public properties

	var markdownParser: IMarkdownParser
	var mdFileManager: IMdFileManager

	// MARK: - Lifecycle

	init(markdownParser: IMarkdownParser, mdFileManager: IMdFileManager) {
		self.markdownParser = markdownParser
		self.mdFileManager = mdFileManager
	}

	// MARK: - Public methods

	func convertMDtoHTML(text: String) -> String {
		let lines = text.components(separatedBy: .newlines)
		var html = [String?]()

		lines.forEach { line in
			let htmlLine = markdownParser.fixHtmlChar(text: line)
			html.append(markdownParser.parseHeader(text: htmlLine))
			html.append(markdownParser.parseCite(text: htmlLine))
			html.append(markdownParser.parseParagraph(text: htmlLine))
		}

		return makeHtml(html.compactMap { $0 }.joined(separator: "\n"))
	}

	// MARK: - Private methods

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
