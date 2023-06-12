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
		password: Password
	) -> AuthorizationResult
}

enum AuthorizationResult {
	case success(AuthToken)
	case failure(Error)
}

class AuthorizationWorker: IAuthorizationWorker {
	let authManager: IOAuthManager

	init(authManager: IOAuthManager) {
		self.authManager = authManager
	}
	func login(
		login: Login,
		password: Password
	) -> AuthorizationResult {
		let semaphore = DispatchSemaphore(value: 0)
		var authorizationResult: AuthorizationResult = .failure(AuthorizationError.unknownError)

		authManager.login(login: login, password: password) { result in
			switch result {
			case .success(let token):
				authorizationResult = .success(token)
			case .failure(let error):
				authorizationResult = .failure(error)
			}

			semaphore.signal()
		}

		_ = semaphore.wait(timeout: .distantFuture)

		return authorizationResult
	}
}
