//
//  Node.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 23.05.2023.
//

import Foundation

protocol INode {
	var children: [INode] {get}
}

class BaseNode: INode {

	// MARK: - Private properties

	private(set) var children: [INode]

	// MARK: - Lifecycle

	internal init(children: [INode] = []) {
		self.children = children
	}
}
