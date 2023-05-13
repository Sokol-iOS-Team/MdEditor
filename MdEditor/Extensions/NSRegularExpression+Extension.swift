//
//  NSRegularExpression+Extension.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 06.05.2023.
//

import Foundation

extension NSRegularExpression {
	func match(_ text: String) -> Bool {
		let range = NSRange(text.startIndex..., in: text)
		return firstMatch(in: text, range: range) != nil
	}
}
