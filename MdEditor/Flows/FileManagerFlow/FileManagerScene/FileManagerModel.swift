//
//  FileManagerModel.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 20.04.2023.
//

import UIKit

// swiftlint:disable nesting
/// Enum, описывающий модели VIP цикла для экрана файлового менеджера
enum FileManagerModel {
	struct ViewModel {
		enum FileType {
			case file
			case folder
		}

		struct File {
			let url: URL
			let name: String
			let attributes: String
			let type: FileType
			let image: UIImage
		}

		struct Section {
			let files: [File]
		}

		let title: String
		let filesBySection: Section
	}

	struct Request {
		enum FileType {
			case file
			case folder
		}

		struct File {
			let url: URL
			let type: FileType
		}
	}

	struct Response {
		struct Section {
			let files: [File]
		}
		let data: Section
		let currentURL: URL?
	}
}
// swiftlint:enable nesting
