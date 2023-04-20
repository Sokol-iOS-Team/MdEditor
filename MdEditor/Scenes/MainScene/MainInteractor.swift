//
//  MainInteractor.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import Foundation

protocol IMainInteractor {
	func fetchData()
}

class MainInteractor: IMainInteractor {

	// MARK: - Dependencies

	private let presenter: IMainPresenter

	// MARK: - Lifecycle

	init(presenter: IMainPresenter) {
		self.presenter = presenter
	}

	// MARK: - Internal Methods

	func fetchData() {
		let menuItems = MenuRepository().getMenuItems()

		presenter.present(response: MainModel.Response(menuItems: menuItems))
	}
}
