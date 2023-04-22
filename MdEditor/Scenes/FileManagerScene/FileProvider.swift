//
//  FileManagerWorker.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 20.04.2023.
//

import Foundation

/// Модель файла
struct File {
	let url: URL
	let attr: [FileAttributeKey: Any]
}

/// Протокол для файлового менеджера
protocol IFileProvider {
	func scan(with url: URL) -> [URL]?
	func getFileAttr(with url: URL) -> [FileAttributeKey: Any]?
}

/// Класса для реализации работы файлового менеджера
final class FileProvider: IFileProvider {

	// MARK: - Dependencies

	private let fileManager = FileManager.default

	// MARK: - Internal Methods

	/// Метод для получения информации о файлах/папках внутри папки
	/// - Parameter url: Содержит url папки/файла
	/// - Returns: Возвращает содержимое папки в виде массива урлов или nil, в случае ошибки
	func scan(with url: URL) -> [URL]? {
		if let urls = try? fileManager.contentsOfDirectory(
			at: url,
			includingPropertiesForKeys: [],
			options: .skipsHiddenFiles
		) {
			return urls
		} else {
			return nil
		}
	}

	/// Метод для получения атрибутов файла/папки
	/// - Parameter url: Содержит url файла/папки
	/// - Returns: Возвращает словарь атрибутов файла/папки или nil, в случае ошибки
	func getFileAttr(with url: URL) -> [FileAttributeKey: Any]? {
		if let attr = try? fileManager.attributesOfItem(atPath: url.path()) {
			return attr
		} else {
			return nil
		}
	}
}
