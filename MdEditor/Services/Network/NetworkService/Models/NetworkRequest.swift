//
//  NetworkRequest.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

/// Протокол для создания сетевых запросов.
public protocol NetworkRequest {
	/// Путь запроса.
	var path: String { get }
	/// HTTP Метод, указывающий тип запроса.
	var method: HTTPMethod { get }
	/// HTTP заголовок.
	var header: HTTPHeader? { get }
	/// Параметры запроса.
	var parameters: Parameters { get }
}

/// Расширение с пустым HTTP заголовком, для удобства составления запросов без заголовка.
extension NetworkRequest {
	/// Значение HTTPHeaders по умолчанию
	public var header: HTTPHeader? { nil }
}
