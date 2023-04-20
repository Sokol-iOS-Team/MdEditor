//
//  MainPresenter.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

protocol IMainPresenter {
	func present(response: MainModel.Response)
}

class MainPresenter: IMainPresenter {

	// MARK: - Dependencies

	private weak var viewController: IMainViewController?

	// MARK: - Lifecycle

	init(viewController: IMainViewController) {
		self.viewController = viewController
	}

	// MARK: - Internal Methods

	func present(response: MainModel.Response) {
		let menuItems = response.menuItems.map { menuItem in
			mapMenuItemData(menuItem: menuItem)
		}

		let viewData = MainModel.ViewData(menuItems: menuItems)

		viewController?.render(viewData: viewData)
	}

	// MARK: - Private

	private func mapMenuItemData(menuItem: MenuItem) -> MainModel.ViewData.MenuItem {
		let icon = UIImage(systemName: menuItem.iconName) ?? UIImage()

		return MainModel.ViewData.MenuItem(icon: icon, title: menuItem.title)
	}
}
