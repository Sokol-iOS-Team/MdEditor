//
//  AuthToken.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

/// Авторизационный токен.
public struct AuthToken: MaskStringConvertible, Codable {
	/// Значение авторизационного токена
	let rawValue: String
}
