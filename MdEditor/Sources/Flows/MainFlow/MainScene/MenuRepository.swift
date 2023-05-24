//
//  MenuRepository.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import Foundation

/// Протокол для создания пунктов меню
protocol IMenuBuilder {
	func getMenuItems() -> [MenuItem]
}

/// Класс для создания пунктов меню
class MenuBuilder: IMenuBuilder {

	// MARK: - Internal Methods

	///  Метод для создания пунктов меню
	/// - Returns: Возвращает массив MenuItem для отображения главном экране
	func getMenuItems() -> [MenuItem] {
		[
			MenuItem(title: "New", iconName: "doc.badge.plus", menuType: .new),
			MenuItem(title: "Open", iconName: "folder", menuType: .open),
			MenuItem(title: "About", iconName: "info.circle", menuType: .about)
		]
	}
}
