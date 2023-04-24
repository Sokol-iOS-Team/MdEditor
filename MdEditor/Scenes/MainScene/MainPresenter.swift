//
//  MainPresenter.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

/// Протокол для подготовки отображения данных на главном экране
protocol IMainPresenter {
	func present(response: MainModel.Response)
}

/// Класс для подготовки отображения данных на главном экране
class MainPresenter: IMainPresenter {

	// MARK: - Dependencies

	private weak var viewController: IMainViewController?

	// MARK: - Lifecycle

	/// Метод инициализации MainPresenter
	/// - Parameter viewController: viewController подписанный на протокол IMainViewController
	init(viewController: IMainViewController) {
		self.viewController = viewController
	}

	// MARK: - Internal Methods

	/// Метод для подготовки отображения данных и передачи их viewController
	/// - Parameter response: принимает MainModel.Response в качестве параметра
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

		return MainModel.ViewData.MenuItem(icon: icon, title: menuItem.title, menuType: menuItem.menuType)
	}
}
