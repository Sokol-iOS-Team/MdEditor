//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import Foundation

protocol IAuthorizationWorker {
	func login(login: String, password: String) -> Bool
}

class AuthorizationWorker: IAuthorizationWorker {
	private let validLogin = "1"
	private let validPassword = "1"

	func login(login: String, password: String) -> Bool {
		login == validLogin && password == validPassword
	}
}
