//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import Foundation

enum AuthorizationModel {
	struct Request {
		var login: Login
		var password: Password
	}

	struct Response {
		var error: Error
	}

	struct ViewModel {
		let errorMessage: String
	}
}
