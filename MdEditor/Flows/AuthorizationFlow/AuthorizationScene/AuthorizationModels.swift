//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import Foundation

enum AuthorizationModels {
	struct Request {
		var login: String
		var password: String
	}

	struct Response {
		var success: Bool
	}

	enum ViewModel {
		case success
		case failure(String)
	}
}
