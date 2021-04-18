//
//  SceneDelegate.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene  = scene as? UIWindowScene else { return }
        let window = UIWindow(frame: scene.coordinateSpace.bounds)
        window.windowScene = scene
        window.rootViewController = UINavigationController(rootViewController: IYInitViewController())
        self.window = window
        self.setupNavBarAppearance()
        window.makeKeyAndVisible()
    }
    func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.backgroundColor = UIColor(named: "systemColor")
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                .font: fontFamilyLittle?.withSize(30) ?? UIFont.systemFont(ofSize: 30)]
        let button = UIBarButtonItemAppearance(style: .plain)
        button.normal.titleTextAttributes = [.foregroundColor: UIColor.white,
                                             .font: fontFamilyLittle?.withSize(20) ?? UIFont.systemFont(ofSize: 20)]
        navBarAppearance.buttonAppearance = button
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        window.rootViewController = vc
        if animated {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: nil)
        }
    }

}
