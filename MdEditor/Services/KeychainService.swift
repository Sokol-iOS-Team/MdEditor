//
//  KeychainService.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 08.06.2023.
//

import Foundation
import Security

/// Структура для работы с Keychain
struct KeychainService {

	// MARK: - Internal Methods

	/// Получает секретную информацию из Keychain.
	/// - Parameters:
	///   - service: Имя сервиса, связанного с секретной информацией.
	///   - account: Имя учетной записи, связанной с секретной информацией.
	/// - Returns: Секретная информация в виде строки или nil, если информация не найдена или возникла ошибка.
	static func getSecret(service: String, account: String) -> String? {
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecReturnData: true,
			kSecMatchLimit: kSecMatchLimitOne,
			kSecClass: kSecClassGenericPassword
		] as [CFString: Any]

		var dataTypeRef: AnyObject?
		let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

		if status == errSecSuccess, let data = dataTypeRef as? Data {
			return String(data: data, encoding: .utf8)
		} else {
			return nil
		}
	}

	/// Сохраняет секретную информацию в Keychain.
	/// - Parameters:
	///   - service: Имя сервиса, связанного с секретной информацией.
	///   - account: Имя учетной записи, связанной с секретной информацией.
	///   - secret: Секретная информация, которую нужно сохранить.
	/// - Returns: true, если секретная информация успешно сохранена, false в противном случае.
	static func saveSecret(service: String, account: String, secret: String) -> Bool {
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecValueData: secret.data(using: .utf8)!,
			kSecClass: kSecClassGenericPassword
		] as [CFString: Any]

		let status = SecItemAdd(query as CFDictionary, nil)
		return status == errSecSuccess
	}

	/// Удаляет секретную информацию из Keychain.
	/// - Parameters:
	///   - service: Имя сервиса, связанного с секретной информацией.
	///   - account: Имя учетной записи, связанной с секретной информацией.
	/// - Returns: true, если секретная информация успешно удалена, false в противном случае.
	static func deleteSecret(service: String, account: String) -> Bool {
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecClass: kSecClassGenericPassword
		] as [CFString: Any]

		let status = SecItemDelete(query as CFDictionary)
		return status == errSecSuccess
	}

	/// Обновляет секретную информацию в Keychain.
	/// - Parameters:
	///   - service: Имя сервиса, связанного с секретной информацией.
	///   - account: Имя учетной записи, связанной с секретной информацией.
	///   - secret: Новая секретная информация.
	/// - Returns: true, если секретная информация успешно обновлена, false в противном случае.
	static func updateSecret(service: String, account: String, secret: String) -> Bool {
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecClass: kSecClassGenericPassword
		] as [CFString: Any]

		let field = [kSecValueData: secret.data(using: .utf8)!] as CFDictionary
		let status = SecItemUpdate(query as CFDictionary, field)
		return status == errSecSuccess
	}
}
