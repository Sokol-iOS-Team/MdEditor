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

		let navigationController = UINavigationController(rootViewController: UIViewController())
		let appCoordinator = AppCoordinator(navigationController: navigationController)

		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		let context = AuthContext()
#if DEBUG
		context.removeAuthDate()
#endif
		let startEntity = StartEntity().selectStartFlow(context: context)

		appCoordinator.start(startEntity)

		self.window = window
	}
}
