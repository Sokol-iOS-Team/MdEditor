//
//  AuthContext.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

/// Класс AuthContext представляет контекст авторизации
///  и предоставляет методы для установки и получения даты авторизации.
final class AuthContext {
	let userDefaults = UserDefaults.standard

/// Метод setAuthDate(date: Date) используется для сохранения даты авторизации в хранилище UserDefaults.
	func setAuthDate(date: Date) {
		userDefaults.set(date, forKey: "authDate")
	}

/// Метод getAuthDate() предназначен для получения ранее сохраненной даты авторизации из хранилища UserDefaults.
	func getAuthDate() -> Date? {
		return userDefaults.object(forKey: "authDate") as? Date
	}

	/// Метод removeAuthDate() используется для удаления сохраненной даты авторизации из хранилища UserDefaults.
	func removeAuthDate() {
		userDefaults.removeObject(forKey: "authDate")
	}
}
