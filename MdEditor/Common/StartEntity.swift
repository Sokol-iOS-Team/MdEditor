//
//  StartEntity.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

protocol IStartEntity {
	func selectStartFlow(context: AuthContext) -> Flow
}

/// класс StartEntity реализует протокол IStartEntity и содержит метод
/// selectStartFlow(context: AuthContext), который определяет, какой поток (flow)
/// должен быть запущен в зависимости от состояния авторизации.
class StartEntity: IStartEntity {

	/// Метод selectStartFlow(context: AuthContext) исползует контекст
	/// для получения даты авторизации с помощью метода getAuthDate() из AuthContext.
	/// - Parameter context: объект типа AuthContext.
	/// - Returns: В зависимости от состояния AuthContext возвращает
	///  значение Flow для определения сценария запуска приложения.
	func selectStartFlow(context: AuthContext) -> Flow {
		guard let date = context.getAuthDate() else { return .authorization }
		if let validAuthDate = Calendar.current.date(byAdding: .day, value: 1, to: date),
		   validAuthDate > Date() {
			return .main
		} else {
			return .authorization
		}
	}
}
