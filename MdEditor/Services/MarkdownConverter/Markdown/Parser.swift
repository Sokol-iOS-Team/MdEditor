//
//  Parser.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 25.05.2023.
//

import Foundation

extension Markdown {
	final class Parser {

		func parse(tokens: [Token]) -> DocumentNode {
			var tokens = tokens
			var result = [INode]()

			while !tokens.isEmpty {
				var nodes = [INode?]()
				nodes.append(parseHeader(tokens: &tokens))
				nodes.append(parseCite(tokens: &tokens))
				nodes.append(parseParagraph(tokens: &tokens))
				nodes.append(parseImage(tokens: &tokens))
				nodes.append(parseBulletedList(tokens: &tokens))
				nodes.append(parseLineBreak(tokens: &tokens))

				let resultNodes = nodes.compactMap { $0 }
				if resultNodes.isEmpty, !tokens.isEmpty {
					tokens.removeFirst()
				} else {
					result.append(contentsOf: resultNodes)
				}
			}

			return DocumentNode(children: result)
		}

		func parseHeader(tokens: inout [Token]) -> HeaderNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case let .header(level, text) = token {
				tokens.removeFirst()
				let textNodes = parseText(token: text)
				return HeaderNode(level: level, children: textNodes)
			}

			return nil
		}

		func parseCite(tokens: inout [Token]) -> CiteNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case let .cite(level, text) = token {
				tokens.removeFirst()
				let textNodes = parseText(token: text)
				return CiteNode(level: level, children: textNodes)
			}

			return nil
		}

		func parseParagraph(tokens: inout [Token]) -> ParagraphNode? {
			var textNodes = [INode]()

			while !tokens.isEmpty {
				guard let token = tokens.first else { return nil }
				if case let .text(text) = token {
					tokens.removeFirst()
					textNodes.append(contentsOf: parseText(token: text))
					textNodes.append(LineBreakNode())
				} else if case .lineBreak = token {
					tokens.removeFirst()
					break
				} else {
					break
				}
			}

			if textNodes.isEmpty {
				return nil
			} else {
				return ParagraphNode(children: textNodes)
			}
		}

		func parseText(token: Text) -> [INode] {
			var textNodes = [INode]()
			token.text.forEach { part in
				switch part {
				case .boldItalic(let text):
					textNodes.append(BoldItalicNode(text: text))
				case .bold(let text):
					textNodes.append(BoldNode(text: text))
				case .italic(let text):
					textNodes.append(ItalicNode(text: text))
				case .normal(let text):
					textNodes.append(TextNode(text: text))
				case .inlineCode(let code):
					textNodes.append(InlineCodeNode(text: code))
				case .escapedChar(let char):
					textNodes.append(EscapedCharNode(text: char))
				}
			}
			return textNodes
		}

		func parseImage(tokens: inout [Token]) -> ImageNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case let .image(url, size) = token {
				tokens.removeFirst()
				return ImageNode(url: url, size: size)
			}

			return nil
		}

		func parseLineBreak(tokens: inout [Token]) -> LineBreakNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case .lineBreak = token {
				tokens.removeFirst()
				return LineBreakNode()
			}

			return nil
		}

		func parseBulletedList(tokens: inout [Token]) -> BulletedListNode? {
			guard let token = tokens.first else {
				return nil
			}

			if case let .bulletedListItem(level, text) = token {
				tokens.removeFirst()
				let textNodes = parseText(token: text)
				return BulletedListNode(level: level, children: textNodes)
			}

			return nil
		}
	}
}
