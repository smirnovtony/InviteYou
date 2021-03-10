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

        // создаем окно
        guard let scene  = scene as? UIWindowScene else { return }
        let window = UIWindow(frame: scene.coordinateSpace.bounds)
        window.windowScene = scene

        window.rootViewController = UINavigationController(rootViewController: IYInitViewController())
        

        // присвоили window из строки 12 наш window из строки 18
        self.window = window

        self.setupNavBarAppearance()

        // делаем окно ключевым и видимым
        window.makeKeyAndVisible()
    }

    func setupNavBarAppearance() { // настройка NavigationBar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground() // стиль
        navBarAppearance.backgroundColor = UIColor(named: "systemColor") // цвет фона
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white] // цвет текста

        let button = UIBarButtonItemAppearance(style: .plain)
        button.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        navBarAppearance.buttonAppearance = button // применение стиля к кнопке, без этого код выше не сработает

        UINavigationBar.appearance().standardAppearance = navBarAppearance //  применение для версий iOS ниже 13
        UINavigationBar.appearance().isTranslucent = true // подсветка
        UINavigationBar.appearance().tintColor = .brown
        UINavigationBar.appearance().barStyle = .black // стиль ночной
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) { // создание ТabВar
        guard let window = self.window else { return }

        window.rootViewController = vc

        if animated { // анимация перехода. Надо animated: Bool = true
            UIView.transition(with: window, // c какой вьюшкой
                              duration: 0.5, // длительность в сек
                              options: .transitionFlipFromLeft, // опции перехода, тип
                              animations: nil) // не надо
        }
    }
}
