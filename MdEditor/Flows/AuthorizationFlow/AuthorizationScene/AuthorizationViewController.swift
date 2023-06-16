//
//  AuthorizationViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 10.06.2023.
//

import UIKit
import PinLayout

#if DEBUG
import SwiftUI
#endif

protocol IAuthorizationViewController: AnyObject {
	func render(viewModel: AuthorizationModel.ViewModel)
}

class AuthorizationViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IAuthorizationInteractor?

	// MARK: - Private properties

	private lazy var textFieldLogin: UITextField = makeTextField()
	private lazy var textFieldPass: UITextField = makeTextField()
	private lazy var buttonLogin: UIButton = makeButtonLogin()
	private var loginText: String {
		get {
			textFieldLogin.text ?? ""
		}
		set {
			textFieldLogin.text = newValue
		}
	}
	private var passText: String {
		get {
			textFieldPass.text ?? ""
		}
		set {
			textFieldPass.text = newValue
		}
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layoutPinLayout()
	}

	// MARK: - Private methods

	private func setupUI() {
		view.backgroundColor = .white
		title = L10n.Authorization.title
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	// MARK: - Actions

	@objc
	func login() {
		let request = AuthorizationModel.Request(
			login: Login(loginText),
			password: Password(passText)
		)
		interactor?.login(request: request)
	}
}

extension AuthorizationViewController: IAuthorizationViewController {
	func render(viewModel: AuthorizationModel.ViewModel) {
		DispatchQueue.main.async {
			self.presentAlert(
				title: L10n.Authorization.alertTitle,
				message: viewModel.errorMessage
			)
		}
	}
}

extension AuthorizationViewController {
	private func layoutPinLayout() {
		view.addSubview(textFieldLogin)
		view.addSubview(textFieldPass)
		view.addSubview(buttonLogin)

		textFieldLogin
			.pin
			.top(Sizes.topOffset)
			.hCenter()
			.width(Sizes.M.maxWidth)
			.height(Sizes.M.height)

		textFieldPass
			.pin
			.hCenter()
			.below(of: textFieldLogin)
			.margin(Sizes.Padding.normal)
			.width(Sizes.M.maxWidth)
			.height(Sizes.M.height)

		buttonLogin
			.pin
			.hCenter()
			.below(of: textFieldPass)
			.margin(Sizes.Padding.double)
			.width(Sizes.L.width)
			.height(Sizes.L.height)
	}

	private func makeTextField() -> UITextField {
		let textField = UITextField()

		textField.backgroundColor = .white
		textField.textColor = .black
		textField.layer.borderWidth = Sizes.borderWidth
		textField.layer.cornerRadius = Sizes.cornerRadius
		textField.layer.borderColor = UIColor.lightGray.cgColor
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Sizes.Padding.half, height: textField.frame.height))
		textField.leftViewMode = .always
		textField.translatesAutoresizingMaskIntoConstraints = false

		return textField
	}

	func makeButtonLogin() -> UIButton {
		let button = UIButton()

		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = .red
		button.configuration?.title = L10n.Authorization.authorization
		button.addTarget(self, action: #selector(login), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}
}
