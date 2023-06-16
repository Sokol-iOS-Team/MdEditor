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
		let parameters = ["login": login.rawValue, "password": password.rawValue]
		let header = ["Accept": "application/json"]
		let request = NetworkRequest(
			path: URLStab.authorizationPath,
			method: .post,
			parameters: .json(parameters),
			header: header
		)

		networkService.performAuth(request) { result in
			switch result {
			case .success(let token):
				completion(.success(token))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
