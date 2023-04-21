//
//  MainInteractor.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import Foundation

/// Протокол для реализации бизнес логики главного экрана
protocol IMainInteractor {
	func fetchData()
}

/// Класс для реализации бизнес логики главного экрана
class MainInteractor: IMainInteractor {

	// MARK: - Dependencies

	private let presenter: IMainPresenter

	// MARK: - Lifecycle

	/// Метод инициализации MainInteractor
	/// - Parameter presenter: presenter подписанный на протокол IMainPresenter
	init(presenter: IMainPresenter) {
		self.presenter = presenter
	}

	// MARK: - Internal Methods

	/// Метод получения элементов меню и их отправки для подготовки отображения
	func fetchData() {
		let menuItems = MenuRepository().getMenuItems()

		presenter.present(response: MainModel.Response(menuItems: menuItems))
	}
}
