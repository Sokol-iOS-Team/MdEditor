//
//  AboutAppViewController.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 26.04.2023.
//

import UIKit
import WebKit
import PinLayout

protocol IAboutAppViewController: AnyObject {
	func render(viewModel: AboutAppModel.ViewModel)
}

class AboutAppViewController: UIViewController {

	// MARK: - Internal Properties

	var viewModel: AboutAppModel.ViewModel = AboutAppModel.ViewModel(html: " ")
	var interactor: IAboutAppInteractor?

	// MARK: - Private properties

	private lazy var aboutAppWebView = makeWebView()

	// MARK: Object lifecycle

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	// MARK: View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		interactor?.fetchData()
		configureViewController()
		addSubviews()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		aboutAppWebView.pin.all()
	}

	// MARK: - Private

	private func configureViewController() {
		title = "About"
	}

	private func addSubviews() {
		view.addSubview(aboutAppWebView)
	}

	private func makeWebView() -> WKWebView {
		let webView = WKWebView()
		webView.allowsBackForwardNavigationGestures = false
		return webView
	}
}

extension AboutAppViewController: IAboutAppViewController {
	/// Метод для отображения данных на главном экране
	/// - Parameter viewModel: принимает  AboutAppModel.ViewModel в качестве параметра
	func render(viewModel: AboutAppModel.ViewModel) {
		self.viewModel = viewModel
		aboutAppWebView.loadHTMLString(viewModel.html, baseURL: nil)
	}
}
