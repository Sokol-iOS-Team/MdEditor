//
//  OAuthManager.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 08.06.2023.
//

import Foundation

protocol IOAuthManager {
	func login(login: Login, password: Password, completion: @escaping (Result<AuthToken, Error>) -> Void)
}

final class OAuthManager: IOAuthManager {
	private var networkService: INetworkService

	init(networkService: INetworkService) {
		self.networkService = networkService
	}

	func login(login: Login, password: Password, completion: @escaping (Result<AuthToken, Error>) -> Void) {
		let parametrs = ["login": login.rawValue, "password": password.rawValue]
		let header = HeaderField.contentType(.json)
		let request = NetworkRequest(
			path: URLStab.authorizationPath,
			method: .post,
			parameters: .json(parametrs),
			header: [(header.key): header.value]
		)

		networkService.performAuth(request, token: nil) { result in
			switch result {
			case .success(let token):
				completion(.success(token))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
