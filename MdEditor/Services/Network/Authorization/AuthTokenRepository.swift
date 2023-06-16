//
//  AuthTokenRepository.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 13.06.2023.
//

import Foundation

/// Протокол для управления токенами авторизации
protocol IAuthTokenRepository {
	/// Получает сохраненный авторизационный токен.
	/// - Returns: Авторизационный токен или nil, если токен не найден или возникла ошибка.
	func getSecret() -> AuthToken?

	/// Сохраняет авторизационный токен.
	/// - Parameter token: Авторизационный токен для сохранения.
	/// - Returns: true, если токен успешно сохранен, false в противном случае.
	func saveSecret(_ token: AuthToken) -> Bool

	/// Удаляет сохраненный авторизационный токен.
	/// - Returns: true, если токен успешно удален, false в противном случае.
	func deleteSecret() -> Bool

	/// Обновляет сохраненный авторизационный токен.
	/// - Parameter token: Новый авторизационный токен.
	/// - Returns: true, если токен успешно обновлен, false в противном случае.
	func updateSecret(_ token: AuthToken) -> Bool
}

/// Класс для управления токенами авторизации 
final class AuthTokenRepository: IAuthTokenRepository {

	// MARK: - Public properties

	private let service: String
	private let account: String

	// MARK: - Initialization

	init(service: String, account: String) {
		self.service = service
		self.account = account
	}

	// MARK: - Internal Methods

	func getSecret() -> AuthToken? {
		if let secret = KeychainService.getSecret(service: service, account: account) {
			return AuthToken(rawValue: secret)
		} else {
			return nil
		}
	}

	func saveSecret(_ token: AuthToken) -> Bool {
		KeychainService.saveSecret(service: service, account: account, secret: token.rawValue)
	}

	func deleteSecret() -> Bool {
		KeychainService.deleteSecret(service: service, account: account)
	}

	func updateSecret(_ token: AuthToken) -> Bool {
		KeychainService.updateSecret(service: service, account: account, secret: token.rawValue)
	}
}
