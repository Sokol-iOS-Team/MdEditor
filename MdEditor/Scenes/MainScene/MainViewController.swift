//
//  ViewController.swift
//  MdEditor
//
//  Created by Артем Соколовский on 17.04.2023.
//

import UIKit
import PinLayout

/// Протокол для отображения данных на главном экране
protocol IMainViewController: AnyObject {
	func render(viewData: MainModel.ViewData)
}

/// Класс для отображения данных главном экране 
class MainViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IMainInteractor?
	var router: IMainRouter?

	// MARK: - Constants

	private let menuItemCellIdentifier = "MenuItemCell"

	// MARK: - Private properties

	private var viewData = MainModel.ViewData(menuItems: [])

	private lazy var menuTableView = makeMenuTableView()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		configureViewController()
		addSubviews()
		interactor?.fetchData()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		menuTableView.pin.all()
	}

	// MARK: - Private

	private func configureViewController() {
		title = L10n.Main.title
	}

	private func addSubviews() {
		view.addSubview(menuTableView)
	}

	private func makeMenuTableView() -> UITableView {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: menuItemCellIdentifier)

		return tableView
	}
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let menuItemData = viewData.menuItems[indexPath.row]

		switch menuItemData.menuType {
		case .open:
			router?.routeFileManager()
		default:
			break
		}
	}
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.menuItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let menuItemData = viewData.menuItems[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: menuItemCellIdentifier, for: indexPath)

		var contentConfiguration = cell.defaultContentConfiguration()
		contentConfiguration.text = menuItemData.title
		contentConfiguration.image = menuItemData.icon

		cell.contentConfiguration = contentConfiguration

		return cell
	}
}

// MARK: - IMainViewController

extension MainViewController: IMainViewController {
	/// Метод для отображения данных на главном экране
	/// - Parameter viewData: принимает MainModel.ViewData в качестве параметра
	func render(viewData: MainModel.ViewData) {
		self.viewData = viewData
		menuTableView.reloadData()
	}
}
