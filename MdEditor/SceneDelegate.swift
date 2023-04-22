//
//  SceneDelegate.swift
//  MdEditor
//
//  Created by Артем Соколовский on 17.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		window.rootViewController = UINavigationController(rootViewController: assembly())
		window.makeKeyAndVisible()

		self.window = window
	}

	private func assembly() -> UIViewController {
		let mainViewController = MainAssembler.assembly()
		let fileManagerViewController = FileManagerAssembler.assembly()

		let mainRouter = MainRouter(
			mainViewController: mainViewController,
			fileManagerViewController: fileManagerViewController
		)

		let fileManagerRouter = FileManagerRouter(fileManagerViewController: fileManagerViewController)

		if let mainViewController = mainViewController as? MainViewController {
			mainViewController.router = mainRouter
		}

		if let fileManagerViewController = fileManagerViewController as? FileManagerViewController {
			fileManagerViewController.router = fileManagerRouter
		}

		return mainViewController
	}
}
