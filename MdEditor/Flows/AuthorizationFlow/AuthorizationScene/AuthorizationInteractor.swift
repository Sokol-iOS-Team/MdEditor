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
	func login(request: AuthorizationModel.Request)
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

	/// Метод логин производит авторизацию на сервере. В случае успеха полученный от сервера
	/// Токен сохраняется в память устройства и производится переход к главной сцене.
	/// В случае провала авторизации выполняется метод present(response: )
	/// AuthorizationPresenter, в качестве response направляется полученная ошибка для дальнейшей обработки.
	/// - Parameter request: структура AuthorizationModels.Request содержит данные для авторизации.
	func login(request: AuthorizationModel.Request) {
		worker.login(login: request.login, password: request.password) { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result {
				case .success(let authToken):
					let authTokenRepository = AuthTokenRepository(service: "MDEditor", account: request.login.rawValue)
					let context = AuthContext()
					if authTokenRepository.saveSecret(authToken) {
						context.setAuthDate(date: Date())
					} else if authTokenRepository.updateSecret(authToken) {
						context.setAuthDate(date: Date())
					} else {
						let response = AuthorizationModel.Response(
							error: AuthorizationError.tokenHasNotBeenSave
						)
						self.presenter?.present(response: response)
					}
						self.coordinator.finish()
				case .failure(let error):
					let response = AuthorizationModel.Response(error: error)
					self.presenter?.present(response: response)
				}
			}
		}
	}
}
