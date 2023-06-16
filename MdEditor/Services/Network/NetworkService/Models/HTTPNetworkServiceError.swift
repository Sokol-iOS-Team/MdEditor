//
//  HTTPNetworkServiceError.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

/// Ошибки сетевого слоя.
public enum HTTPNetworkServiceError: Error {
	/// Сетевая ошибка.
	case networkError(Error)
	/// Ответ сервера имеет неожиданный формат.
	case invalidResponse(URLResponse?)
	/// Статус кода ответа не входит в диапазон успешных `(200..<300)`.
	case invalidStatusCode(Int, Data?)
	/// Данные отсутствуют.
	case noData
	/// Не удалось декодировать ответ.
	case failedToDecodeResponse(Error)
}
