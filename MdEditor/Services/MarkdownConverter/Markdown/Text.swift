//
//  Text.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 24.05.2023.
//

import Foundation

extension Markdown {
	struct Text {
		let text: [Part]

		enum Part { // swiftlint:disable:this nesting
			case boldItalic(text: String)
			case bold(text: String)
			case italic(text: String)
			case normal(text: String)
			case inlineCode(text: String)
			case escapedChar(text: String)
		}

		init(text: [Part]) {
			self.text = text
		}
	}
}
