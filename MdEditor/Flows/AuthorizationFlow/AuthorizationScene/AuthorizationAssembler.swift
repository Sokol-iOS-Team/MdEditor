//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import UIKit

final class AuthorizationAssembler {
	static func assembly(coordinator: IAuthorizationCoordinator) -> UIViewController {

		let authorizationViewController = AuthorizationViewController()
		let presenter = AuthorizationPresenter(viewController: authorizationViewController)
		let networkService = NetworkService(
			session: URLSession(configuration: .default),
			requestBuilder: URLRequestBuilder(baseUrl: URLStab.baseURL)
		)
		let authManager = OAuthManager(networkService: networkService)
		let worker = AuthorizationWorker(authManager: authManager)
		let interactor = AuthorizationInteractor(
			worker: worker,
			presenter: presenter,
			coordinator: coordinator
		)
		authorizationViewController.interactor = interactor

		return authorizationViewController
	}
}
