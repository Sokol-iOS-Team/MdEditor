//
//  MainModel.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

// swiftlint:disable nesting
/// Enum, описывающий модели VIP цикла для главного экрана
enum MainModel {
	struct Request {

	}

	struct Response {
		let menuItems: [MenuItem]
	}

	struct ViewData {
		struct MenuItem {
			let icon: UIImage
			let title: String
			let menuType: MenuTypes
		}

		let menuItems: [MenuItem]
	}
}
// swiftlint:enable nesting
