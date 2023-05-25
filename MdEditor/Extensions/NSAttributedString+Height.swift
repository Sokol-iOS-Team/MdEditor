//
//  NSAttributedString+Height.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 25.05.2023.
//

import Foundation

extension NSAttributedString {
	func height(withConstrainedWidth width: CGFloat) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

		return ceil(boundingBox.height)
	}
}
