//
//  KeychainService.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 08.06.2023.
//

import Foundation
import Security

protocol AccessTokenRepository {
	func saveAccessToken(token: String) -> Bool
	func getAccessToken() -> String?
	func deletetAccessToken() -> Bool
	func updatetAccessToken(token: String) -> Bool
}

final class KeychainService: AccessTokenRepository {
	let service: String
	let account: String

	init(service: String, account: String) {
		self.service = service
		self.account = account
	}

	func saveAccessToken(token: String) -> Bool {
		let keychainItem = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecValueData: token.data(using: .utf8)!,
			kSecClass: kSecClassInternetPassword
		] as [CFString: Any] as CFDictionary

		let status = SecItemAdd(keychainItem, nil)
		return status == errSecSuccess
	}

	func getAccessToken() -> String? {
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecReturnData: true,
			kSecMatchLimit: kSecMatchLimitOne,
			kSecClass: kSecClassInternetPassword
		] as [CFString: Any] as CFDictionary

		var dataTypeRef: AnyObject?
		let status = SecItemCopyMatching(query, &dataTypeRef)

		if status == errSecSuccess, let data = dataTypeRef as? Data {
			return String(data: data, encoding: .utf8)
		} else {
			return nil
		}
	}

	func deletetAccessToken() -> Bool {
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecClass: kSecClassInternetPassword
		] as [CFString: Any] as CFDictionary

		let status = SecItemDelete(query)
		return status == errSecSuccess
	}

	func updatetAccessToken(token: String) -> Bool {
		let query = [
			kSecAttrService: service,
			kSecAttrAccount: account,
			kSecClass: kSecClassInternetPassword
		] as [CFString: Any] as CFDictionary

		let field = [
			kSecValueData: token.data(using: .utf8)!
		] as [CFString: Any] as CFDictionary

		let status = SecItemUpdate(query, field)

		return status == errSecSuccess
	}
}
