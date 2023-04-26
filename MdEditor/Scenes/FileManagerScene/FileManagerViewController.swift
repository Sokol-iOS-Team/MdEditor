//
//  FileManagerViewController.swift
//  MdEditor
//
//  Created by Владимир Свиридов on 20.04.2023.
//

import UIKit
import PinLayout

/// Протокол для отображения данных на экране файлового менеджера
protocol IFileManagerViewController: AnyObject {
	func render(viewModel: FileManagerModel.ViewModel)
}

/// Класс для реализации отображения данных на экране файлового менеджера
final class FileManagerViewController: UITableViewController {

	// MARK: - Dependencies

	var interactor: IFileManagerInteractor?
	var router: IFileManagerRouter?

	// MARK: - Public Properties

	var currentFile: FileManagerModel.ViewModel.File?

	// MARK: - Constants

	private let fileManagerItemCellIdentifier = "FileManagerItemCell"

	// MARK: - Private Properties

	private lazy var fileManagerTableView = makeFileManagerTableView()
	private var viewModel: FileManagerModel.ViewModel = FileManagerModel.ViewModel(filesBySection: .init(files: []))
	private let rootTitle = "/"

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureViewController()
		self.addSubviews()

		interactor?.fetchData(request: FileManagerModel.Request.FileURL(url: currentFile?.url))
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		self.tableView.pin.all()
	}

	// MARK: - TableViewDataSource

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.filesBySection.files.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: fileManagerItemCellIdentifier, for: indexPath)
		let file = viewModel.filesBySection.files[indexPath.row]
		var contentConfiguration = cell.defaultContentConfiguration()
		contentConfiguration.attributedText = NSAttributedString(
			string: file.name,
			attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
		)
		contentConfiguration.secondaryText = file.attributes
		contentConfiguration.image = file.image
		cell.contentConfiguration = contentConfiguration

		return cell
	}

	// MARK: - TableViewDelegate

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let file = viewModel.filesBySection.files[indexPath.row]

		if file.type == .folder {
			router?.openFileManager(with: file, router: router)
		} else {
			// Тут должен открываться экран редактирования документа
		}
	}

	// MARK: - Private Methods

	private func configureViewController() {
		self.title = currentFile == nil ? rootTitle : currentFile?.name
	}

	private func addSubviews() {
		view.addSubview(fileManagerTableView)
	}

	private func makeFileManagerTableView() -> UITableView {
		let tableView = UITableView()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: fileManagerItemCellIdentifier)
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.dataSource = self
		self.tableView.delegate = self

		return tableView
	}
}

// MARK: - ITodoListViewController

extension FileManagerViewController: IFileManagerViewController {
	func render(viewModel: FileManagerModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
