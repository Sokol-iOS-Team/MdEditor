//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

protocol IAuthorizationPresenter {
	func present(responce: AuthorizationModel.Response)
}

class AuthorizationPresenter: IAuthorizationPresenter {

	// MARK: - Dependencies

	private weak var viewController: IAuthorizationViewController?

	// MARK: - Lifecycle

	init(viewController: IAuthorizationViewController?) {
		self.viewController = viewController
	}

	// MARK: - Internal Methods

	func present(responce: AuthorizationModel.Response) {
		let viewModel = AuthorizationModel.ViewModel.init(
			errorMessage: (handleError(error: responce.error))
		)
		viewController?.render(viewModel: viewModel)
	}

	// MARK: - Private Methods
// TODO: - реализовать подготовку сообщений об ошибке.

	/// Метод handleError подготавливает сообщение для отображения на экране
	/// в зависимости от типа полученной ошибки.
	/// - Parameter error: Ошибка полученная в процессе авторизации.
	/// - Returns: Релевантное сообщение из Localizable string.
	private func handleError(error: Error) -> String {
		return error.localizedDescription
	}
}
