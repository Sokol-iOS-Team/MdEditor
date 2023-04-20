//
//  MenuRepository.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import Foundation

protocol IMenuRepository {
	func getMenuItems() -> [MenuItem]
}

class MenuRepository: IMenuRepository {

	// MARK: - Internal Methods

	func getMenuItems() -> [MenuItem] {
		[
			MenuItem(title: "New", iconName: "doc.badge.plus"),
			MenuItem(title: "Open", iconName: "folder"),
			MenuItem(title: "About", iconName: "info.circle")
		]
	}

}
