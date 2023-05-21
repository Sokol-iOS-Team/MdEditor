//
//  MenuItem.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import Foundation

/// Перечисление элементов меню на главном экране
enum MenuTypes {
	case new
	case open
	case about
}

/// Модель данных для элемента меню на главном экране
struct MenuItem {
	let title: String
	let iconName: String
	let menuType: MenuTypes
}
