//
//  AboutAppInteractor.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 26.04.2023.
//

import UIKit

protocol IAboutAppInteractor {
	func fetchData()
}

class AboutAppInteractor: IAboutAppInteractor {

	var presenter: IAboutAppPresenter?
	private var mdFileManager: IMdFileManager?

	// MARK: - Lifecycle

	/// Метод инициализации MainInteractor
	/// - Parameter presenter: presenter подписанный на протокол IMainPresenter
	/// - Parameter mdFileManager: FileProviderAdapter подписанный на протокол IFileProviderAdapter
	init(presenter: IAboutAppPresenter, mdFileManager: IMdFileManager) {
		self.presenter = presenter
		self.mdFileManager = mdFileManager
	}

	func fetchData() {
		let fileName = "About"
		guard let fileUrl = mdFileManager?.getFileUrlByName(
			folderName: .rootFolder,
			fileName: fileName,
			fileExtension: .markDown
		) else {
			fatalError("Файл About.md не сушествует")
		}
		presenter?.present(response: AboutAppModel.Response(url: fileUrl))
	}
}
