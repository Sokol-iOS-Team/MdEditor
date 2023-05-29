//
//  HeaderNode.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 23.05.2023.
//

import Foundation

final class HeaderNode: BaseNode {

	// MARK: - Public properties

	let level: Int

	// MARK: - Lifecycle

	internal init(level: Int, children: [INode]) {
		self.level = level
		super.init(children: children)
	}
}
