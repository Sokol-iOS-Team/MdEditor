//
//  FileManagerAttrWorker.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 21.04.2023.
//

import UIKit

/// Протокол для работы с атрибутами файла
protocol IFileManagerAttrWorker {
	func getViewModelFiles(with files: [File]) -> [FileManagerModel.ViewModel.File]
}

/// Класс для реализации работы с атрибутами файла
final class FileManagerAttrWorker: IFileManagerAttrWorker {

	// MARK: - Internal Methods

	/// Возвращает файлы в виде модели отображения данных
	/// - Parameter files: Содержит массив файлов, полученных из файлового менеджера
	/// - Returns: Содержит модель массива файлов для отображения
	func getViewModelFiles(with files: [File]) -> [FileManagerModel.ViewModel.File] {
		var onlyFolders = [FileManagerModel.ViewModel.File]()
		var onlyFiles = [FileManagerModel.ViewModel.File]()

		files.forEach {
			if getFileType(with: $0) == .folder {
				onlyFolders.append(getViewModelFile(with: $0))
			} else {
				onlyFiles.append(getViewModelFile(with: $0))
			}
		}

		return onlyFolders + onlyFiles
	}

	// MARK: - Private Methods

	private func getFormattedSize(with file: File) -> String {
		var value = (file.attr[FileAttributeKey.size] as? Double ?? .zero)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while value > 1024 {
			value /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", value, tokens[multiplyFactor])
	}

	private func getFileType(with file: File) -> FileManagerModel.ViewModel.FileTypes {
		if (file.attr[FileAttributeKey.type] as? FileAttributeType) == .typeDirectory {
			return .folder
		} else {
			return .file
		}
	}

	private func getFormattedAttributes(with file: File) -> String {
		let formattedSize = getFormattedSize(with: file)
		let ext = file.url.pathExtension
		let modificationDate = (file.attr[FileAttributeKey.modificationDate] as? Date) ?? Date()
		let type = getFileType(with: file)
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		if type == .folder {
			return "\(dateFormatter.string(from: modificationDate)) | <dir>"
		} else {
			return "\"\(ext)\" – \(dateFormatter.string(from: modificationDate)) | \(formattedSize)"
		}
	}

	private func getViewModelFile(with file: File) -> FileManagerModel.ViewModel.File {
		let folderImageName = "folder"
		let fileImageName = "doc.text"
		let type = getFileType(with: file)

		return FileManagerModel.ViewModel.File(
			url: file.url,
			name: file.url.lastPathComponent,
			attributes: getFormattedAttributes(with: file),
			type: type,
			image: (type == .folder ? UIImage(systemName: folderImageName) : UIImage(systemName: fileImageName)) ?? UIImage()
		)
	}
}
