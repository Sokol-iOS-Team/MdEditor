//
//  HtmlVisitor.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 25.05.2023.
//

import Foundation

class HtmlVisitor: IVisitor {

	// MARK: - Internal Methods

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
		fixHTMLChar(text: node.text)
	}

	func visit(node: BoldNode) -> String {
		"<strong>\(fixHTMLChar(text: node.text))</strong>"
	}

	func visit(node: ItalicNode) -> String {
		"<em>\(fixHTMLChar(text: node.text))</em>"
	}

	func visit(node: BoldItalicNode) -> String {
		"<strong><em>\(fixHTMLChar(text: node.text))</em></strong>"
	}

	func visit(node: InlineCodeNode) -> String {
		"<code>\(fixHTMLChar(text: node.text))</code>"
	}

	func visit(node: ImageNode) -> String {
		"<img src=\"\(node.url)\" alt\"\" />"
	}

	func visit(node: LineBreakNode) -> String {
		"<br/>"
	}

	func  visit(node: BulletedListNode) -> String {
		let result = visitChildren(of: node).joined()
		return "<li>\(result)</li>"
	}

	// MARK: - Private

	private func fixHTMLChar(text: String) -> String {
		text.replacingOccurrences(of: "<", with: "&lt;").replacingOccurrences(of: ">", with: "&gt;")
	}
}
