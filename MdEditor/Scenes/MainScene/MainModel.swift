//
//  MainModel.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

// swiftlint:disable all
/// Enum, описывающий модели VIP цикла для главного экрана
enum MainModel {
	enum FetchMenu {
		struct Response {
			let menuItems: [MenuItem]
		}

		struct ViewModel {
			struct MenuItem {
				let icon: UIImage
				let title: String
				let menuType: MenuTypes
			}

			let menuItems: [MenuItem]
		}
	}
	
	enum NewFile {
		struct Request {
			let name: String
		}
		enum Response {
			case success
			case failure(title: String, message: String)
		}
		enum ViewModel {
			case success
			case failure(title: String, message: String)
		}
	}
}
// swiftlint:enable all
