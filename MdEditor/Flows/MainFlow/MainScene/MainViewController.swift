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
	func render(viewModel: MainModel.FetchMenu.ViewModel)
	func renderFile(viewModel: MainModel.NewFile.ViewModel)
}

/// Класс для отображения данных главном экране 
class MainViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IMainInteractor?

	// MARK: - Constants

	private let menuItemCellIdentifier = "MenuItemCell"

	// MARK: - Private properties

	private var viewModel = MainModel.FetchMenu.ViewModel(menuItems: [])

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
		let menuItemData = viewModel.menuItems[indexPath.row]

		switch menuItemData.menuType {
		case .open:
			interactor?.openFileManager()
		case .new:
			presentTextFieldAlert(
				title: L10n.Main.NewFileAlert.title,
				placeholder: L10n.Main.NewFileAlert.placeholder,
				okActionTitle: L10n.Main.NewFileAlert.okActionTitle
			) { [weak self] name in
				let request = MainModel.NewFile.Request(name: name)
				self?.interactor?.createFile(request: request)
			}
		case .about:
			interactor?.openAboutApp()
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.menuItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let menuItemData = viewModel.menuItems[indexPath.row]
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
	/// - Parameter viewModel: принимает MainModel.FetchMenu.ViewModel в качестве параметра
	func render(viewModel: MainModel.FetchMenu.ViewModel) {
		self.viewModel = viewModel
		menuTableView.reloadData()
	}
	/// Отображает результат создания файла.
	/// При успешном создании перенаправляет на детальный экран, при неудаче показывает Alert
	/// - Parameter viewModel: принимает MainModel.NewFile.ViewModel в качестве параметра
	func renderFile(viewModel: MainModel.NewFile.ViewModel) {
		switch viewModel {
		case .success:
			// router.routeToNewFile()
			presentAlert(
				title: L10n.Main.FileCreatedAlert.title,
				message: L10n.Main.FileCreatedAlert.message
			)
		case .failure(title: let title, message: let message):
			presentAlert(title: title, message: message)
		}
	}
}
