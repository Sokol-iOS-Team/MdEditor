//
//  HTTPHeader.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

public typealias HTTPHeader = [String: String]

/// Поля HTTP-заголовка. Содержит список часто используемых полей заголовка для устранения хардкода и избежания ошибок
/// написания полей.
public enum HeaderField {
	/// Авторизация, содержит токен и используется для OAuth2 авторизации
	case authorization(AuthToken)
	/// Тип контента, содержит тип к
	case contentType(ContentType)

	/// Название ключа заголовка.
	public var key: String {
		switch self {
		case .authorization:
			return "Authorization"
		case .contentType:
			return "Content-Type"
		}
	}

	/// Значение поля заголовка.
	public var value: String {
		switch self {
		case .authorization(let token):
			return "Bearer \(token.rawValue)"
		case .contentType(let contentType):
			return contentType.value
		}
	}
}
