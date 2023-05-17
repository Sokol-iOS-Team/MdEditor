//
//  EditFileModel.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 05.05.2023.
//

import Foundation

/// Enum, описывающий модели VIP цикла для экрана редактирования файла
enum EditFileModel {

	struct ViewModel {
		let title: String
		let text: String
	}

	struct Response {
		let url: URL
	}
}
