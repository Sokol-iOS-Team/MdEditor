//
//  AboutAppPresenter.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 26.04.2023.
//

import UIKit

protocol IAboutAppPresenter {
	func present(response: AboutAppModel.Response)
}

class AboutAppPresenter: IAboutAppPresenter {
	weak var viewController: IAboutAppViewController?
	private var markdownConverter: IMarkdownСonverter?

	// MARK: - Lifecycle

	/// Метод инициализации MainPresenter
	/// - Parameter viewController: viewController подписанный на протокол IMainViewController
	init(viewController: IAboutAppViewController, markdownConverter: IMarkdownСonverter) {
		self.viewController = viewController
		self.markdownConverter = markdownConverter
	}

	func present(response: AboutAppModel.Response) {
		guard let mdString = try? String(contentsOf: response.url) else { fatalError("Some error") }
		guard let html = markdownConverter?.convertMDtoHTML(text: mdString) else {return}

		viewController?.render(viewModel: AboutAppModel.ViewModel(html: html))
	}
}
