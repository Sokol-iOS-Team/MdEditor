//
//  MainRouter.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import Foundation

protocol IMainRouter {
	func route()
}

class MainRouter: IMainRouter {

	// MARK: - Dependencies

	private weak var mainViewController: IMainViewController?

	// MARK: - Lifecycle

	init(mainViewController: IMainViewController) {
		self.mainViewController = mainViewController
	}

	// MARK: - Internal Methods

	func route() {

	}
}
