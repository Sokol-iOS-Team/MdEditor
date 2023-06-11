//
//  MaskStringConvertible.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 11.06.2023.
//

import Foundation

public protocol MaskStringConvertible: CustomStringConvertible, CustomDebugStringConvertible { }

public extension MaskStringConvertible {
	var description: String {
		"***********"
	}

	var debugDescription: String {
		"***********"
	}
}
