//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import Foundation

protocol IAuthorizationInteractor {
	func login(request: AuthorizationModels.Request)
}

enum AuthorizationError: Error {
	case unknownError
	case tokenHasNotBeenSave
}

class AuthorizationInteractor: IAuthorizationInteractor {
	private var worker: IAuthorizationWorker
	private var presenter: IAuthorizationPresenter?
	private let coordinator: IAuthorizationCoordinator

	init(
		worker: IAuthorizationWorker,
		presenter: IAuthorizationPresenter,
		coordinator: IAuthorizationCoordinator
	) {
		self.worker = worker
		self.presenter = presenter
		self.coordinator = coordinator
	}

	func login(request: AuthorizationModels.Request) {
		let result = worker.login(login: request.login, password: request.password)
		switch result {
		case .success(let authToken):
			let keychainService = KeychainService(service: "MDEditor", account: request.login.rawValue)
			let isTokenSaved = keychainService.saveAccessToken(token: authToken.rawValue)

			if isTokenSaved {
				let context = AuthContext()
				context.setAuthDate(date: Date())
			} else {
				let responce = AuthorizationModels.Response(error: AuthorizationError.tokenHasNotBeenSave)
				presenter?.present(responce: responce)
			}
			self.coordinator.showMainFlow()
		case .failure(let error):
			let responce = AuthorizationModels.Response(error: error)
			presenter?.present(responce: responce)
		}
	}
}
