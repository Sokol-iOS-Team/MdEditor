//
//  EditFileCoordinator.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 05.05.2023.
//

import UIKit

/// Протокол координатора экрана редактирования файла
protocol IEditFileCoordinator: ICoordinator {
	func showFilePreview()
}

/// Класс координатора экрана редактирования файла
final class EditFileCoordinator: IEditFileCoordinator {

	// MARK: - Internal properties

	var navigationController: UINavigationController
	var childCoordinators = [ICoordinator]()
	weak var finishDelegate: ICoordinatorFinishDelegate?

	// MARK: - Private Properties

	private let currentURL: URL?

	// MARK: - Lifecycle

	/// Метод инициализации класса EditFileCoordinator
	/// - Parameters:
	///   - navigationController: навигационный viewController для отображения экрана
	///   - finishDelegate: класс, подписанный на протокол ICoordinatorFinishDelegate
	///   - currentURL: url файла
	init(
		navigationController: UINavigationController,
		finishDelegate: ICoordinatorFinishDelegate?,
		currentURL: URL?
	) {
		self.navigationController = navigationController
		self.finishDelegate = finishDelegate
		self.currentURL = currentURL
	}

	// MARK: - ICoordinator

	func start(_ flow: Flow? = nil) {
		let editFileViewController = EditFileAssembler.assembly(coordinator: self, currentURL: currentURL)
		navigationController.pushViewController(editFileViewController, animated: false)
	}

	func finish() {
		navigationController.popViewController(animated: false)
		childCoordinators.removeAll()
		finishDelegate?.didFinish(self)
	}

	// MARK: - IEditFileCoordinator

	func showFilePreview() {
		let previewMarkdownViewController = PreviewMarkdownAssembler.assembly(coordinator: self, currentURL: currentURL)
		navigationController.pushViewController(previewMarkdownViewController, animated: false)
	}
}
