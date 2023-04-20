//
//  ViewController.swift
//  MdEditor
//
//  Created by Артем Соколовский on 17.04.2023.
//

import UIKit
import PinLayout

protocol IMainViewController: AnyObject {
	func render(viewData: MainModel.ViewData)
}

class MainViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IMainInteractor?

	// MARK: - Constants

	private enum Constants {
		enum MenuTableView {
			static let cellIdentifier = "MenuItemCell"
		}
	}

	// MARK: - Private properties

	private var viewData = MainModel.ViewData(menuItems: [])

	private lazy var menuTableView = makeMenuTableView()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		configureView()
		addSubviews()
		interactor?.fetchData()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		menuTableView.pin.all()
	}

	// MARK: - Private

	private func configureView() {
//		title = L10n.Main.title
	}

	private func addSubviews() {
		view.addSubview(menuTableView)
	}

	private func makeMenuTableView() -> UITableView {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.MenuTableView.cellIdentifier)

		return tableView
	}
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.menuItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let menuItemData = viewData.menuItems[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MenuTableView.cellIdentifier, for: indexPath)

		var contentConfiguration = cell.defaultContentConfiguration()
		contentConfiguration.text = menuItemData.title
		contentConfiguration.image = menuItemData.icon

		cell.contentConfiguration = contentConfiguration

		return cell
	}
}

// MARK: - IMainViewController

extension MainViewController: IMainViewController {
	func render(viewData: MainModel.ViewData) {
		self.viewData = viewData
		menuTableView.reloadData()
	}
}
