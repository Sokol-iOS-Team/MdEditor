//
//  MainAssembler.swift
//  MdEditor
//
//  Created by Dmitry Troshkin on 20.04.2023.
//

import UIKit

class MainAssembler {

	// MARK: - Internal Methods

	static func assembly() -> UIViewController {
		let mainViewController = MainViewController()

		let mainPresenter = MainPresenter(viewController: mainViewController)
		let mainInteractor = MainInteractor(presenter: mainPresenter)
		mainViewController.interactor = mainInteractor

		return mainViewController
	}
}
