//
//  DocumentRepository.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 22.06.2023.
//

import Foundation

struct Document {
	let name: String
	let creationDate: Date
	let modificationDate: Date
	let type: `Type`

	enum `Type` {
		case localFolder(pathId: String)
		case localFile(pathId: String)
		case remoteFile(id: String)
	}
}

protocol IDocumentRepository {
	func documentList(completion: @escaping ([Document]) -> Void)
	func getDocument(id: String) -> Document?
	func updateDocument(id: String)
	func deleteDocument(id: String)
}
