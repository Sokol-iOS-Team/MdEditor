//
//  Sequense+Joined.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 23.05.2023.
//

import Foundation

extension Sequence where Iterator.Element == NSMutableAttributedString {

/// Метод joined() выполняет операцию объединения всех элементов последовательности в один
/// NSMutableAttributedString, используя метод reduce(into:).
/// - Returns: возвращается новый NSMutableAttributedString, в который последовательно добавляются
/// все элементы из исходной последовательности.
	func joined() -> NSMutableAttributedString {
		reduce(into: NSMutableAttributedString()) { $0.append($1) }
	}
}
