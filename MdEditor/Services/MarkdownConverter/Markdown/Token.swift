//
//  Token.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 24.05.2023.
//

import Foundation

extension Markdown {

	enum Token {
		case header(level: Int, text: Text)
		case cite(level: Int, text: Text)
		case text(text: Text)
		case bulletedListItem(level: Int, text: Text)
		case numberedListItem(level: Int, text: Text)
		// TODO - обезопасить тип передаваемого URL при помощи property wrapper.
		case link(url: String, text: String)
		case image(url: String, size: String)
		case lineBreak
		case codeBlockMarker(level: Int, lang: String)
		case codeLine(text: String)
	}
}
