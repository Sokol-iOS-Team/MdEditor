//
//  MarkdownLexer.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 24.05.2023.
//

import Foundation

/// Регулярные выражения для определения группы текста.
enum RegexPatern {
	static let header = #"^(#{1,6}) "#
	static let cite = #"^>{1,6}(.*)"#
	static let notParagraph = #"^[#>]"#

	// TODO - Реализовать парсинг по регулярным выражениям для списка и нумерованного списка.
	static let list = #"^([ \t]*)-\s+(.*)"#
	static let numberList = #"^([ \t]*)[\d]+\.\s+(.*)"#
}

extension Markdown {
	/// Класс Lexer является компонентом MarkdownConverter и выполняет задачи лексического анализа,
	/// разбивая исходный текст на токены с использованием регулярных выражений.
	final class Lexer {

		// MARK: - Private properties

		/// Регулярные выражения для определения стилизации текста.
		private let partRegexes = [
			PartRegex(type: .escapedChar, pattern: #"^\\([\\\`\*\_\{\}\[\]\<\>\(\)\+\-\.\!\|#]){1}"#),
			PartRegex(type: .normal, pattern: #"^(.*?)(?=[\*`\\]|$)"#),
			PartRegex(type: .boldItalic, pattern: #"^\*\*\*(.*?)\*\*\*"#),
			PartRegex(type: .bold, pattern: #"^\*\*(.*?)\*\*"#),
			PartRegex(type: .italic, pattern: #"^\*(.*?)\*"#),
			PartRegex(type: .inline, pattern: #"^`(.*?)`"#)
		]

		// MARK: - Public methods

		func tokenize(_ input: String) -> [Token] {
			let lines = input.components(separatedBy: .newlines)
			var tokens = [Token?]()

			for line in lines {
				tokens.append(parseLineBreak(rawText: line))
				tokens.append(parseHeader(rawText: line))
				tokens.append(parseCite(rawText: line))
				tokens.append(parseTextBlock(rawText: line))
			}

			return tokens.compactMap { $0 }
		}
	}
}

private extension Markdown.Lexer {
	func parseLineBreak(rawText: String) -> Markdown.Token? {
		if rawText.trimmingCharacters(in: .whitespaces).isEmpty {
			return .lineBreak
		}

		return nil
	}

	func parseHeader(rawText: String) -> Markdown.Token? {
		let pattern = RegexPatern.header
		if let header = rawText.range(of: pattern, options: .regularExpression) {
			let text = String(rawText[header.upperBound...])
			let level = rawText.filter { $0 == "#" }.count

			return .header(level: level, text: parseText(rawText: text))
		}

		return nil
	}

	func parseCite(rawText: String) -> Markdown.Token? {
		let pattern = RegexPatern.cite
		if let text = rawText.group(for: pattern) {
			let level = rawText.filter { $0 == ">" }.count
			return .cite(level: level, text: parseText(rawText: text))
		}
		return nil
	}

	func parseTextBlock(rawText: String) -> Markdown.Token? {
		if rawText.isEmpty { return nil }

		let notParagraphPattern = RegexPatern.notParagraph
		let regex = try? NSRegularExpression(pattern: notParagraphPattern)

		if let notParagraph = regex?.match(rawText), notParagraph == true { return nil }

		return .text(text: parseText(rawText: rawText))
	}
}

private extension Markdown.Lexer {
	struct PartRegex {
		let type: PartType
		let regex: NSRegularExpression

		enum PartType: String { // swiftlint:disable:this nesting
			case normal
			case bold
			case italic
			case boldItalic
			case inline
			case escapedChar
		}

		init(type: PartType, pattern: String) {
			self.type = type
			self.regex = try! NSRegularExpression(pattern: pattern) // swiftlint:disable:this force_try
		}
	}

	func parseText(rawText text: String) -> Markdown.Text {

		var parts = [Markdown.Text.Part]()
		var range = NSRange(text.startIndex..., in: text)

		while range.location != NSNotFound && range.length != 0 {
			let startPartsCont = parts.count
			for partRegex in partRegexes {
				if let match = partRegex.regex.firstMatch(in: text, range: range),
				   let group0 = Range(match.range(at: 0), in: text),
				   let group1 = Range(match.range(at: 1), in: text) {
					let extractedText = String(text[group1])
					if !extractedText.isEmpty {
						parts.append(getPart(partRegex: partRegex, extractedText: extractedText))
						range = NSRange(group0.upperBound..., in: text)
						break
					}
				}
			}
			if parts.count == startPartsCont {
				guard let range = Range(range, in: text) else {
					fatalError("Unexpected error in extracting range")
				}
				let extractedText = String(text[range])
				parts.append(.normal(text: extractedText))
				break
			}
		}
		return Markdown.Text(text: parts)
	}

	func getPart(
		partRegex: Markdown.Lexer.PartRegex,
		extractedText: String
	) -> Markdown.Text.Part {
		switch partRegex.type {
		case .normal:
			return Markdown.Text.Part.normal(text: extractedText)
		case .boldItalic:
			return Markdown.Text.Part.boldItalic(text: extractedText)
		case .bold:
			return Markdown.Text.Part.bold(text: extractedText)
		case .italic:
			return Markdown.Text.Part.italic(text: extractedText)
		case .inline:
			return Markdown.Text.Part.inlineCode(text: extractedText)
		case .escapedChar:
			return Markdown.Text.Part.escapedChar(text: extractedText)
		}
	}
}
