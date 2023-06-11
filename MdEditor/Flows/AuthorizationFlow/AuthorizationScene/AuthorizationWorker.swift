//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import Foundation

protocol IAuthorizationWorker {
	func login(
		login: AuthorizationModels.Login,
		password: AuthorizationModels.Password
	) -> Bool
}

class AuthorizationWorker: IAuthorizationWorker {
	private let validLogin = "1"
	private let validPassword = "1"

	func login(
		login: AuthorizationModels.Login,
		password: AuthorizationModels.Password
	) -> Bool {
		login.rawValue == validLogin && password.rawValue == validPassword
	}
}
