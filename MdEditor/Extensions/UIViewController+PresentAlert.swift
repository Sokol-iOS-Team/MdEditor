//
//  UIViewController+PresentAlert.swift
//  MdEditor
//
//  Created by Supodoco on 25.04.2023.
//

import UIKit

extension UIViewController {
	/// Метод вызывает UIAlertController с TextField
	/// - Parameters:
	///   - title: Заголовок
	///   - placeholder: UITextField.placeholder
	///   - okActionTitle: Заголовок кнопки
	///   - completion: Метод кнопки okAction
	func presentTextFieldAlert(
		title: String,
		placeholder: String,
		okActionTitle: String,
		completion: @escaping (String) -> Void
	) {
		let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
		alert.addTextField { [weak self] textField in
			textField.placeholder = placeholder
			textField.addTarget(
				self,
				action: #selector(self?.textFieldDidChange(_:)),
				for: .editingChanged
			)
		}
		alert.addAction(UIAlertAction(
			title: L10n.Extensions.UIViewController.CustomAlert.cancelButton,
			style: .destructive
		))
		alert.addAction(
			UIAlertAction(
				title: okActionTitle,
				style: .default,
				handler: { _ in
					guard let name = alert.textFields?.first?.text else { return }
					completion(name)
				}
			)
		)
		alert.actions.last?.isEnabled = false
		present(alert, animated: true)
	}
	/// Метод отключает последнюю кнопку в UIAlertController, при кол-ве символов меньше двух
	/// - Parameter textField: textField
	@objc private func textFieldDidChange(_ textField: UITextField) {
		guard
			let alert = presentedViewController as? UIAlertController,
			let textCount = textField.text?.count
		else { return }
		alert.actions.last?.isEnabled = textCount > 1
	}

	/// Метод вызывает простой UIAlertController для отображения title и message
	func presentAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(
			title: L10n.Extensions.UIViewController.SimpleAlert.buttonTitle,
			style: .default
		))
		present(alert, animated: true)
	}
}
