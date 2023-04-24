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
		enum FileTypes {
			case file
			case folder
		}

		struct File {
			let url: URL
			let name: String
			let attributes: String
			let type: FileTypes
			let image: UIImage
		}

		struct Section {
			let files: [File]
		}

		let filesBySection: Section
	}

	struct Request {
		struct FileURL {
			let url: URL?
		}
	}

	struct Response {
		struct Section {
			let files: [File]
		}
		let data: Section
	}
}
// swiftlint:enable nesting
