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
		let responce = AuthorizationModels.Response(success: result)

		if responce.success {
			let context = AuthContext()
			context.setAuthDate(date: Date())
			self.coordinator.showMainFlow()
		} else {
			presenter?.present(responce: responce)
		}
	}
}
