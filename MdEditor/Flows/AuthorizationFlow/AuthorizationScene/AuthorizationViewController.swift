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
	func render(viewModel: AuthorizationModels.ViewModel)
}

class AuthorizationViewController: UIViewController {

	private lazy var textFieldLogin: UITextField = makeTextField()
	private lazy var textFieldPass: UITextField = makeTextField()
	private lazy var buttonLogin: UIButton = makeButtonLogin()

	var interactor: IAuthorizationInteractor?

	var loginText: String {
		get {
			textFieldLogin.text ?? ""
		}

		set {
			textFieldLogin.text = newValue
		}
	}

	var passText: String {
		get {
			textFieldPass.text ?? ""
		}

		set {
			textFieldPass.text = newValue
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layoutPinLayout()
	}

	@objc
	func login() {
		let request = AuthorizationModels.Request(
			login: Login(loginText),
			password: Password(passText)
		)
		interactor?.login(request: request)
	}

	private func setupUI() {
		view.backgroundColor = .white
		title = L10n.Authorization.title
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}

extension AuthorizationViewController: IAuthorizationViewController {
	func render(viewModel: AuthorizationModels.ViewModel) {
		switch viewModel {
		case .success: break
		case .failure(let message):
			presentAlert(
				title: L10n.Authorization.alertTitle,
				message: message
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

#if DEBUG
struct ViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
			AuthorizationViewController().preview()
		}
	}
}
#endif
