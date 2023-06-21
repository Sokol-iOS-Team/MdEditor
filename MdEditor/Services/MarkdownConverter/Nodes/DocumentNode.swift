//
//  DocumentNode.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 23.05.2023.
//

import Foundation

final class DocumentNode: BaseNode {
}

extension DocumentNode {
	func accept<T: IVisitor>(visitor: T) -> [T.Result] {
		visitor.visit(node: self)
	}
}
