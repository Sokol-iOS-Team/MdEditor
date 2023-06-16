//
//  ResponseStatus.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

/// Коды ответа сервера на запрос.
public enum ResponseStatus {
	/// Информационный статус.
	case information(Int)
	/// Статус успешного выполнения запросса.
	case success(Int)
	/// Перенаправление.
	case redirect(Int)
	/// Ошибка клиента.
	case clientError(Int)
	/// Ошибка сервера.
	case serverError(Int)

	init?(rawValue: Int) {
		if ResponseCode.informationalCodes.contains(rawValue) {
			self = .information(rawValue)
		} else if ResponseCode.successCodes.contains(rawValue) {
			self = .success(rawValue)
		} else if ResponseCode.redirectCodes.contains(rawValue) {
			self = .redirect(rawValue)
		} else if ResponseCode.clientErrorCodes.contains(rawValue) {
			self = .clientError(rawValue)
		} else if ResponseCode.serverErrorCodes.contains(rawValue) {
			self = .serverError(rawValue)
		} else {
			return nil
		}
	}

	/// Возвращает true, если статус был success.
	var isSuccess: Bool {
		switch self {
		case .success:
			return true
		default:
			return false
		}
	}
}
