//
//  URL+Date.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 23.06.2023.
//

import Foundation

extension URL {

	// MARK: - Internal Properties

	var modificationDate: Date {
		date(resourceKey: .contentModificationDateKey)
	}

	var creationDate: Date {
		date(resourceKey: .creationDateKey)
	}

	// MARK: - Private

	private func date(resourceKey: URLResourceKey) -> Date {
		let url = self as NSURL
		var value : AnyObject?
		try? url.getResourceValue(&value, forKey: resourceKey)
		if let date = value as? Date {

			return date
		}

		return .distantPast
	}
}
