//
//  String+RegularExpression.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 06.05.2023.
//

import Foundation

extension String {
	func group(for regexPattern: String) -> String? {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let range = NSRange(location: .zero, length: text.utf16.count)

			if let match = regex.firstMatch(in: text, options: [], range: range),
			   let group = Range(match.range(at: 1), in: text) {
				return String(text[group])
			}
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
		}
		return nil
	}
}
