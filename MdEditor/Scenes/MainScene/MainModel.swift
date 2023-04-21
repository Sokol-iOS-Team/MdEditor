//
//  MainModel.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

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
		}

		let menuItems: [MenuItem]
	}
}
