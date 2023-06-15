//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import Foundation

protocol IAuthorizationWorker {
	func login(
		login: Login,
		password: Password,
		completion: @escaping (AuthorizationResult) -> Void
	)
}

enum AuthorizationResult {
	case success(AuthToken)
	case failure(Error)
}

class AuthorizationWorker: IAuthorizationWorker {

	// MARK: - Dependencies

	let authManager: IOAuthManager

	// MARK: - Lifecycle

	init(authManager: IOAuthManager) {
		self.authManager = authManager
	}

	// MARK: - Internal Methods

	func login(
		login: Login,
		password: Password,
		completion: @escaping (AuthorizationResult) -> Void
	) {
		authManager.login(login: login, password: password) { result in
				switch result {
				case .success(let token):
					completion(.success(token))
				case .failure(let error):
					completion(.failure(error))
				}
			}
	}
}
