//
//  URLComponents+setParameters.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

extension URLComponents {
	/// Устанавливает параметры в виде словаря [String: Any] и возвращается новая структура URLComponents.
	/// - Parameter parameters: Параметры для URLComponents.
	/// - Returns: новая структура URLComponents с установленными параметрами.
	public func setParameters(_ parameters: [String: Any]) -> URLComponents {
		var urlComponents = self
		urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: String(describing: $1)) }
		return urlComponents
	}
}
