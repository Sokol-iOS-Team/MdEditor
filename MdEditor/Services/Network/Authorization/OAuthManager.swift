//
//  OAuthManager.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 08.06.2023.
//

import Foundation

class OAuthManager {
	let authorizationURL = "https://practice.swiftbook.org/api/auth/login"

	private var networkService: INetworkService
	private var urlRequestBuilder:IURLRequestBuilder

	init(networkService: INetworkService, urlRequestBuilder: IURLRequestBuilder) {
		self.networkService = networkService
		self.urlRequestBuilder = urlRequestBuilder
	}

	func auth(login: Login, password: Password) {
		let networkRequest = URLRequest(url: authorizationURL)

	}
}
