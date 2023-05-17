//
//  MainPresenter.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

/// Протокол для подготовки отображения данных на главном экране
protocol IMainPresenter {
	func present(response: MainModel.FetchMenu.Response)
	func provideAlertInfo(response: MainModel.NewFile.Response)
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
	func present(response: MainModel.FetchMenu.Response) {
		let menuItems = response.menuItems.map { menuItem in
			mapMenuItemData(menuItem: menuItem)
		}

		let viewModel = MainModel.FetchMenu.ViewModel(menuItems: menuItems)

		viewController?.render(viewModel: viewModel)
	}
	/// Метод перенаправляет результат создания файла
	/// - Parameter response: принимает MainModel.NewFile.Response в качестве параметра
	func provideAlertInfo(response: MainModel.NewFile.Response) {
		let viewModel: MainModel.NewFile.ViewModel
		switch response {
		case .success:
			viewModel = .success
		case .failure(let title, let message):
			viewModel = .failure(title: title, message: message)
		}
		viewController?.renderFile(viewModel: viewModel)
	}

	// MARK: - Private

	private func mapMenuItemData(menuItem: MenuItem) -> MainModel.FetchMenu.ViewModel.MenuItem {
		let icon = UIImage(systemName: menuItem.iconName) ?? UIImage()

		return MainModel.FetchMenu.ViewModel.MenuItem(icon: icon, title: menuItem.title, menuType: menuItem.menuType)
	}
}
