//
//  AboutAppModels.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 26.04.2023.
//

import UIKit

/// Enum, описывающий модели VIP цикла для экрана "О приложении"
enum AboutAppModel {
	struct Response {
		let url: URL
	}
	struct ViewModel {
		let html: String
	}
}
