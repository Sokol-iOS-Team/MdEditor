//
//  MarkdownParser.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 28.04.2023.
//

import Foundation

protocol IMarkdownParser {
	func fixHtmlChar(text: String) -> String
	func parseHeader(text: String) -> String?
	func parseCite(text: String) -> String?
	func parseParagraph(text: String) -> String?
}

/// MarkdownParser реализует метод преобразования строк с разметкой Markdown в NSAttributedString
///  для возможности отображения текста с форматированием,
final class MarkdownParser: IMarkdownParser {

	// MARK: - Public methods

	func fixHtmlChar(text: String) -> String {
		text
			.replacing("<", with: "&lt;")
			.replacing(">", with: "&gt;")
	}

	func parseHeader(text: String) -> String? {
		let pattern = #"^#{1,6} "#

		if let headerRange = text.range(of: pattern, options: .regularExpression) {
			let headerText = text[headerRange.upperBound...]
			let headerLevel = text.filter { $0 == "#" }.count
			return "<h\(headerLevel)>\(headerText)</h\(headerLevel)>"
		}

		return nil
	}

	func parseCite(text: String) -> String? {
		let pattern = #"^&gt; (.*)"#
		if let citeText = text.group(for: pattern) {
			return "<cite>\(citeText)</cite>"
		}

		return nil
	}

	func parseParagraph(text: String) -> String? {
		let pattern = #"^(#|&gt;)"#

		let regex = try? NSRegularExpression(pattern: pattern)
		if let noParagraph = regex?.match(text), noParagraph == true { return nil }

		let parsedText = parseText(text: text)
		return "<p>\(parsedText)</p>"
	}

	// MARK: - Private methods

	private func parseText(text: String) -> String {
		let italicPattern = #"\*(.*?)\*"#
		let boldPattern = #"\*\*(.*?)\*\*"#
		let boldItalicPattern = #"\*\*\*(.*?)\*\*\*"#

		var result = text.replacingOccurrences(
			of: boldItalicPattern,
			with: "<strong><em>$1</em></strong>",
			options: .regularExpression
		)

		result = result.replacingOccurrences(
			of: boldPattern,
			with: "<strong>$1</strong>",
			options: .regularExpression
		)

		result = result.replacingOccurrences(
			of: italicPattern,
			with: "<em>$1</em>",
			options: .regularExpression
		)

		return result
	}
}
