//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import Foundation

/// Протокол для реализации авторизации
protocol IAuthorizationInteractor {
	/// Метод авторизации
	/// - Parameter request: получает модель запроса, содержащую логин и пароль
	func login(request: AuthorizationModels.Request)
}

enum AuthorizationError: Error {
	case unknownError
	case tokenHasNotBeenSave
}

class AuthorizationInteractor: IAuthorizationInteractor {

	// MARK: - Dependencies

	private var worker: IAuthorizationWorker
	private var presenter: IAuthorizationPresenter?
	private let coordinator: IAuthorizationCoordinator

	// MARK: - Lifecycle

	init(
		worker: IAuthorizationWorker,
		presenter: IAuthorizationPresenter,
		coordinator: IAuthorizationCoordinator
	) {
		self.worker = worker
		self.presenter = presenter
		self.coordinator = coordinator
	}

	// MARK: - Internal Methods

	func login(request: AuthorizationModels.Request) {
		let result = worker.login(login: request.login, password: request.password)
		switch result {
		case .success(let authToken):
			let authTokenRepository = AuthTokenRepository(service: "MDEditor", account: request.login.rawValue)
			let context = AuthContext()
			if authTokenRepository.saveSecret(authToken) {
				context.setAuthDate(date: Date())
			} else if authTokenRepository.updateSecret(authToken) {
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
