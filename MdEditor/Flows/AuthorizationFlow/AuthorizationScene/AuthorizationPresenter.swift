//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

protocol IAuthorizationPresenter {
	func present(responce: AuthorizationModels.Response)
}

class AuthorizationPresenter: IAuthorizationPresenter {
	private weak var viewController: IAuthorizationViewController?

	init(viewController: IAuthorizationViewController?) {
		self.viewController = viewController
	}

	func present(responce: AuthorizationModels.Response) {
		let viewModel = AuthorizationModels.ViewModel.init(
			errorMessage: (handleError(error: responce.error))
		)
		viewController?.render(viewModel: viewModel)
	}

	func handleError(error: Error) -> String {
		return error.localizedDescription
	}
}
