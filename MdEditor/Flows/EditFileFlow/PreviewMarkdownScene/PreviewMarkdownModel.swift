//
//  PreviewMarkdownModel.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 31.05.2023.
//

import Foundation

/// Enum, описывающий модели VIP цикла для экрана просмотра превью файла
enum PreviewMarkdownModel {
	struct ViewModel {
		let data: Data
	}

	struct Responce {
		let url: URL
	}
}
