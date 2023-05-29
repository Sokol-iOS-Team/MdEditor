//
//  HtmlVisitor.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 25.05.2023.
//

import Foundation

class HtmlVisitor: IVisitor {
	func visit(node: Document) -> [String] {
		let result = visitChildren(of: node)
		return result
	}

	func visit(node: HeaderNode) -> String {
		let result = visitChildren(of: node).joined()
		return "<h\(node.level)>\(result)</h\(node.level)>"
	}

	func visit(node: ParagraphNode) -> String {
		let result = visitChildren(of: node).joined()
		return "<p>\(result)</p>"
	}

	func visit(node: CiteNode) -> String {
		let result = visitChildren(of: node).joined()
		return "<cite>\(result)</cite>"
	}

	func visit(node: TextNode) -> String {
		node.text
	}

	func visit(node: BoldNode) -> String {
		"<strong>\(node.text)</strong>"
	}

	func visit(node: ItalicNode) -> String {
		"<em>\(node.text)</em>"
	}

	func visit(node: BoldItalicNode) -> String {
		"<strong><em>\(node.text)</em></strong>"
	}

	func visit(node: ImageNode) -> String {
		"<img src=\"\(node.url)\" alt\"\" />"
	}

	func visit(node: LineBreakNode) -> String {
		"<br/>"
	}
}
