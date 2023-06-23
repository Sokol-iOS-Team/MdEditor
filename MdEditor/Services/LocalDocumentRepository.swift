//
//  LocalDocumentRepository.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 23.06.2023.
//

import Foundation

protocol ILocalDocumentRepository: IDocumentRepository {
	func documentList(by url: URL) -> [Document]
}

final class LocalDocumentRepository: ILocalDocumentRepository {

	// MARK: - Dependencies

	private var fileManager: FileManager

	// MARK: - Private Properties

	private enum Constants {
		static let rootFolder = "Examples"
	}

	// MARK: - Lifecycle

	init(fileManager: FileManager) {
		self.fileManager = fileManager
	}

	func documentList(completion: @escaping ([Document]) -> Void) {
		guard
			let mainFolderURL = mainFolderURL(),
			let documentsFolderURL = documentsFolderURL(),
			let mainFolder = getDocument(by: mainFolderURL),
			let documentsFolder = getDocument(by: documentsFolderURL)
		else {
			completion([])
			return
		}

		completion([mainFolder, documentsFolder])
	}

	func documentList(by url: URL) -> [Document] {
		var documents = [Document]()

		if let urls = try? FileManager.default.contentsOfDirectory(
			at: url,
			includingPropertiesForKeys: [],
			options: .skipsHiddenFiles
		) {
			urls.forEach { url in
				if let document = getDocument(by: url) {
					documents.append(document)
				}
			}
		}

		return documents
	}

	func getDocument(id: String) -> Document? {
		let url = URL(filePath: id)

		return getDocument(by: url)
	}

	func updateDocument(id: String) {}

	func deleteDocument(id: String) {}

	// MARK: - Private Methods

	private func mainFolderURL() -> URL? {
		Bundle.main.url(forResource: Constants.rootFolder, withExtension: "")
	}

	private func documentsFolderURL() -> URL? {
		try? FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: true)
	}

	private func getDocument(by url: URL) -> Document? {
		let type: Document.`Type` =
		url.hasDirectoryPath
		? .localFolder(pathId: url.path())
		: .localFile(pathId: url.path())

		return Document(
			name: url.lastPathComponent,
			creationDate: url.creationDate,
			modificationDate: url.modificationDate,
			type: type
		)
	}
}
