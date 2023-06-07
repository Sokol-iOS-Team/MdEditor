//
//  RawAttribitedTextVisitor.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 25.05.2023.
//

import UIKit

class RawAttribitedTextVisitor: IVisitor {

	func visit(node: Document) -> [NSMutableAttributedString] {
		let result = visitChildren(of: node)
		return result
	}

	func visit(node: HeaderNode) -> NSMutableAttributedString {
		let text = visitChildren(of: node).joined()
		let code = makeMarkDownCode(String(repeating: "#", count: node.level) + " ")

		let result = NSMutableAttributedString()
		result.append(code)
		result.append(text)
		result.append(String.lineBreak)
		result.append(String.lineBreak)
		let sizes: [CGFloat] = [32, 30, 28, 26, 25, 22, 20]

		result.addAttribute(.font, value: UIFont.systemFont(ofSize: sizes[node.level]), range: NSRange(0..<result.length))

		return result
	}

	func visit(node: ParagraphNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined()
		result.append(String.lineBreak)
		result.append(String.lineBreak)
		return result
	}

	func visit(node: CiteNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined()
		return result
	}

	func visit(node: TextNode) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.systemFont(ofSize: 18)
		]

		let result = NSMutableAttributedString(string: node.text, attributes: attributes)
		return result
	}

	func visit(node: BoldNode) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.blue,
			.font: UIFont.boldSystemFont(ofSize: 18)
		]

		let mdcode = makeMarkDownCode("**")
		let attributedString = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(mdcode)
		result.append(attributedString)
		result.append(mdcode)

		return result
	}

	func visit(node: ItalicNode) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.italicSystemFont(ofSize: 18)
		]

		let mdcode = makeMarkDownCode("*")
		let attributedString = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(mdcode)
		result.append(attributedString)
		result.append(mdcode)

		return result
	}

	func visit(node: BoldItalicNode) -> NSMutableAttributedString {

		let font: UIFont

		if let fontDescriptor = UIFontDescriptor
			.preferredFontDescriptor(withTextStyle: .body)
			.withSymbolicTraits([.traitBold, .traitItalic]) {
			font = UIFont(descriptor: fontDescriptor, size: 18)
		} else {
			font = UIFont.boldSystemFont(ofSize: 18)
		}

		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: font
		]

		let mdcode = makeMarkDownCode("***")
		let attributedString = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(mdcode)
		result.append(attributedString)
		result.append(mdcode)

		return result
	}

	func visit(node: InlineCodeNode) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.lightGray,
			.font: UIFont.monospacedSystemFont(ofSize: 16.0, weight: .regular)
		]
		let mdcode = makeMarkDownCode("`")
		let attributedString = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(mdcode)
		result.append(attributedString)
		result.append(mdcode)

		return result
	}

	func visit(node: ImageNode) -> NSMutableAttributedString {
		let imageAttachment = NSTextAttachment()
		imageAttachment.image = UIImage(named: node.url)

		let imageString = NSAttributedString(attachment: imageAttachment)
		let mdcode = makeMarkDownCode("![[\(node.url)]]\n")

		let result = NSMutableAttributedString()
		result.append(imageString)
		result.append(mdcode)

		return result
	}

	private func makeMarkDownCode(_ code: String) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.lightGray
		]

		let result = NSMutableAttributedString(string: code, attributes: attributes)
		return result
	}

	func visit(node: LineBreakNode) -> NSMutableAttributedString {
		NSMutableAttributedString(string: "\n")
	}

	func visit(node: BulletedListNode) -> NSMutableAttributedString {
		let text = visitChildren(of: node).joined()
		let spacing = String(repeating: "  ", count: node.level)

		let markerAttributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.systemFont(ofSize: 10)
		]

		let marker = NSMutableAttributedString(string: spacing + "●  ", attributes: markerAttributes)
		marker.append(text)

		return marker
	}
}
