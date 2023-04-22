//
//  FileManagerWorker.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 21.04.2023.
//

import Foundation

/// Протокол для адаптера файлового менеджера
protocol IFileManagerFileProviderAdapter {
	func getRootFolders() -> [File]
	func scan(with url: URL) -> [File]
}

/// Класс для реализации работы адаптера файлового менеджера
final class FileManagerFileProviderAdapter: IFileManagerFileProviderAdapter {

	// MARK: - Dependencies

	private let fileProvider: IFileProvider

	// MARK: - Lifecycle

	/// Метод инициализации FileManagerFileProviderAdapter
	/// - Parameters:
	///   - viewController: fileProvider подписанный на протокол IFileProvider
	init(fileProvider: IFileProvider) {
		self.fileProvider = fileProvider
	}

	// MARK: - Internal Methods

	/// Метод для получения корневых папок
	/// - Returns: Возвращает корневые папки в виде модели массива файлов
	func getRootFolders() -> [File] {
		guard
			let mainFolder = getMainFolder(),
			let documentFolder = getDocumentFolder()
		else { return [] }

		return [mainFolder, documentFolder]
	}

	/// Метод для получения информации о файлах/папках внутри папки
	/// - Parameter url: Содержит url папки/файла
	/// - Returns: Возвращает содержимое папки в виде модели массива файлов
	func scan(with url: URL) -> [File] {
		var files = [File]()

		if let urls = fileProvider.scan(with: url) {
			urls.forEach {
				if let attr = fileProvider.getFileAttr(with: $0) {
					files.append(File(url: $0, attr: attr))
				}
			}
		}

		return files
	}

	// MARK: - Private Methods

	private func getMainFolder() -> File? {
		let rootFolderName = "Examples"

		guard
			let mainFolderURL = Bundle.main.url(forResource: rootFolderName, withExtension: ""),
			let mainFolderAttr = fileProvider.getFileAttr(with: mainFolderURL)
		else { return nil }

		return File(url: mainFolderURL, attr: mainFolderAttr)
	}

	private func getDocumentFolder() -> File? {
		guard
			let documentFolderURL = try? FileManager.default.url(
				for: .documentDirectory,
				in: .userDomainMask,
				appropriateFor: nil,
				create: false
			),
			let documentFolderAttr = fileProvider.getFileAttr(with: documentFolderURL)
		else { return nil }

		return File(url: documentFolderURL, attr: documentFolderAttr)
	}
}
