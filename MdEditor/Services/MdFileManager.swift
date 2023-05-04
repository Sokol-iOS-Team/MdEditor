//
//  MdFileManager.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 27.04.2023.
//

import Foundation

/// Модель файла
struct File {
	let url: URL
	let attr: [FileAttributeKey: Any]
}

/// Модель ошибок
enum CreateFileErrors: Error {
	case fileExist
}

/// Протокол для файлового менеджера
protocol IMdFileManager {
	func createFile(withName name: String) throws
	func readFile(with url: URL) -> File?
	func updateFile()
	func deleteFile()
	func scanFolder(with url: URL) -> [File]
	func getRootFolders() -> [File]
}

/// Класса для реализации работы файлового менеджера
final class MdFileManager: IMdFileManager {

	// MARK: - Internal Properties

	/// Создает новый файл
	/// - Parameters:
	///   - name: имя файла
	///   - url: путь для создания файла
	func createFile(withName name: String) throws {
		guard let documentFolderURL = getDocumentsFolderURL() else { return }
		let filePath = documentFolderURL
			.appending(component: name)
			.appendingPathExtension("md")
		if FileManager.default.fileExists(atPath: filePath.path()) {
			throw CreateFileErrors.fileExist
		}
		try? "".write(to: filePath, atomically: true, encoding: .utf8)
	}

	/// Возвращает данные о файле
	/// - Parameter url: путь до файла
	/// - Returns: модель файла, либо nil при неуспешном чтении файла
	func readFile(with url: URL) -> File? {
		do {
			let attr = try FileManager.default.attributesOfItem(atPath: url.path(percentEncoded: false))
			return File(url: url, attr: attr)
		} catch {
			print(error.localizedDescription)
			return nil
		}
	}

	/// Обновляет файл
	func updateFile() {}

	/// Удаляет файл
	func deleteFile() {}

	/// Возвращает содержимое папки
	/// - Parameter url: путь до папки
	/// - Returns: модель файлов
	func scanFolder(with url: URL) -> [File] {
		var files = [File]()

		if let urls = try? FileManager.default.contentsOfDirectory(
			at: url,
			includingPropertiesForKeys: [],
			options: .skipsHiddenFiles
		) {
			urls.forEach { url in
				if let file = readFile(with: url) {
					files.append(file)
				}
			}
		}
		return files
	}

	func getRootFolders() -> [File] {
		guard
			let mainFolderURL = getMainFolderURL(),
			let documentsFolderURL = getDocumentsFolderURL(),
			let mainFolder = readFile(with: mainFolderURL),
			let documentsFolder = readFile(with: documentsFolderURL)
		else { return [] }

		return [mainFolder, documentsFolder]
	}

	private func getMainFolderURL() -> URL? {
		let rootFolderName = "Examples"

		return Bundle.main.url(forResource: rootFolderName, withExtension: "")
	}

	private func getDocumentsFolderURL() -> URL? {
		try? FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: true)
	}
}
