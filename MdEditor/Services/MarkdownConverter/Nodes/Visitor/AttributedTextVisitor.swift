//
//  AttributedTextVisitor.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 23.05.2023.
//

import UIKit

class AttribitedTextVisitor: IVisitor {
	func visit(node: Document) -> [NSMutableAttributedString] {
		let result = visitChildren(of: node)
		return result
	}

	func visit(node: HeaderNode) -> NSMutableAttributedString {
		let text = visitChildren(of: node).joined()
		let result = NSMutableAttributedString()
		result.append(text)
		let sizes: [CGFloat] = [32, 30, 28, 26, 25, 22, 20]

		result.addAttribute(.font, value: UIFont.systemFont(ofSize: sizes[node.level]), range: NSRange(0..<result.length))

		return result
	}

	func visit(node: ParagraphNode) -> NSMutableAttributedString {
		let result = visitChildren(of: node).joined()
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

		let attributedString = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(attributedString)

		return result
	}

	func visit(node: ItalicNode) -> NSMutableAttributedString {
		let attributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black,
			.font: UIFont.italicSystemFont(ofSize: 18)
		]

		let attributedString = NSMutableAttributedString(string: node.text, attributes: attributes)

		let result = NSMutableAttributedString()
		result.append(attributedString)

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

		let result = NSMutableAttributedString(string: node.text, attributes: attributes)

		return result
	}

	func visit(node: ImageNode) -> NSMutableAttributedString {
		let imageAttachment = NSTextAttachment()
		imageAttachment.image = UIImage(named: node.url)

		let imageString = NSAttributedString(attachment: imageAttachment)

		let result = NSMutableAttributedString()
		result.append(imageString)

		return result
	}

	func visit(node: LineBreakNode) -> NSMutableAttributedString {
		NSMutableAttributedString(string: "\n")
	}
}
