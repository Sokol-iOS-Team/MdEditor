//
//  ImageNode.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 23.05.2023.
//

import Foundation

final class ImageNode: BaseNode {

	// MARK: - Public properties

	let url: String
	let size: String

	// MARK: - Lifecycle

	init(url: String, size: String) {
		self.url = url
		self.size = size
	}
}
