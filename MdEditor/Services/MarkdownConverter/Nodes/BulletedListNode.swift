//
//  BulletedListNode.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 06.06.2023.
//

import Foundation

final class BulletedListNode: BaseNode {

	let level: Int

	init(level: Int, children: [INode]) {
		self.level = level
		super.init(children: children)
	}
}
