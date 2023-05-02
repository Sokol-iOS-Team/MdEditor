//
//  FileManagerPresenter.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 20.04.2023.
//

import UIKit

/// Протокол для подготовки отображения данных на экране файлового менеджера
protocol IFileManagerPresenter {
	func present(response: FileManagerModel.Response)
}

/// Класс для реализации подготовки отображения данных на экране файлового менеджера
final class FileManagerPresenter: IFileManagerPresenter {

	// MARK: - Dependencies

	private weak var viewController: IFileManagerViewController?

	// MARK: - Lifecycle

	/// Метод инициализации FileManagerPresenter
	/// - Parameters:
	///   - viewController: viewController подписанный на протокол IFileManagerViewController
	init(viewController: IFileManagerViewController) {
		self.viewController = viewController
	}

	// MARK: - Internal Methods

	/// Метод для подготовки отображения данных и передачи их viewController
	/// - Parameter response: Содержит модель массива файлов, полученных из файлового менеджера и url текущей директории
	func present(response: FileManagerModel.Response) {
		let section = FileManagerModel.ViewModel.Section(files: mapFilesData(with: response.data.files))
		let title = getTitle(from: response.currentURL)

		let viewModel = FileManagerModel.ViewModel(title: title, filesBySection: section)

		viewController?.render(viewModel: viewModel)
	}

	// MARK: - Private Methods

	private func mapFilesData(with files: [File]) -> [FileManagerModel.ViewModel.File] {
		var onlyFolders = [FileManagerModel.ViewModel.File]()
		var onlyFiles = [FileManagerModel.ViewModel.File]()

		files.forEach {
			if getFileType(with: $0) == .folder {
				onlyFolders.append(mapFileData(with: $0))
			} else {
				onlyFiles.append(mapFileData(with: $0))
			}
		}

		return onlyFolders + onlyFiles
	}

	private func mapFileData(with file: File) -> FileManagerModel.ViewModel.File {
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

	private func getFileType(with file: File) -> FileManagerModel.ViewModel.FileType {
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

	private func getTitle(from url: URL?) -> String {
		guard let url = url else { return "/" }

		return url.lastPathComponent
	}
}
