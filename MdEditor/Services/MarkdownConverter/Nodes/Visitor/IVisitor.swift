//
//  IVisitor.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 23.05.2023.
//

import Foundation

protocol IVisitor {
	associatedtype Result

	func visit(node: DocumentNode) -> [Result]
	func visit(node: HeaderNode) -> Result
	func visit(node: ParagraphNode) -> Result
	func visit(node: CiteNode) -> Result
	func visit(node: TextNode) -> Result
	func visit(node: BoldNode) -> Result
	func visit(node: ItalicNode) -> Result
	func visit(node: BoldItalicNode) -> Result
	func visit(node: InlineCodeNode) -> Result
	func visit(node: LineBreakNode) -> Result
	func visit(node: ImageNode) -> Result
	func visit(node: BulletedListNode) -> Result
}

// swiftlint:disable cyclomatic_complexity
extension IVisitor {
	public func visitChildren(of node: INode) -> [Result] {
		return node.children.compactMap { child in
			switch child {
			case let child as HeaderNode:
				return visit(node: child)
			case let child as ParagraphNode:
				return visit(node: child)
			case let child as CiteNode:
				return visit(node: child)
			case let child as TextNode:
				return visit(node: child)
			case let child as BoldNode:
				return visit(node: child)
			case let child as ItalicNode:
				return visit(node: child)
			case let child as BoldItalicNode:
				return visit(node: child)
			case let child as InlineCodeNode:
				return visit(node: child)
			case let child as LineBreakNode:
				return visit(node: child)
			case let child as ImageNode:
				return visit(node: child)
			case let child as BulletedListNode:
				return visit(node: child)
			default:
				return nil
			}
		}
	}
}
// swiftlint:enable cyclomatic_complexity
