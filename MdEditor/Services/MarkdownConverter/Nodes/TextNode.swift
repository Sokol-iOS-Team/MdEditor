//
//  TextNode.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 23.05.2023.
//

import Foundation

final class TextNode: BaseNode {

	// MARK: - Public properties

	let text: String

	// MARK: - Lifecycle

	init(text: String) {
		self.text = text
	}
}

final class BoldItalicNode: BaseNode {

	// MARK: - Public properties

	let text: String

	// MARK: - Lifecycle

	init(text: String) {
		self.text = text
	}
}

final class BoldNode: BaseNode {

	// MARK: - Public properties

	let text: String

	// MARK: - Lifecycle

	init(text: String) {
		self.text = text
	}
}

final class ItalicNode: BaseNode {

	// MARK: - Public properties

	let text: String

	// MARK: - Lifecycle

	init(text: String) {
		self.text = text
	}
}

final class InlineCodeNode: BaseNode {

	// MARK: - Public properties

	let text: String

	// MARK: - Lifecycle

	init(text: String) {
		self.text = text
	}
}

final class EscapedCharNode: BaseNode {

	// MARK: - Public properties

	let text: String

	// MARK: - Lifecycle

	init(text: String) {
		self.text = text
	}
}

final class LineBreakNode: BaseNode { }
