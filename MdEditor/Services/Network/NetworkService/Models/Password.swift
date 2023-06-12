//
//  Password.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

/// Пароль пользователя.
public struct Password: MaskStringConvertible {
	/// Значение пароля.
	let rawValue: String

	init(_ rawValue: String) {
		self.rawValue = rawValue
	}
}
