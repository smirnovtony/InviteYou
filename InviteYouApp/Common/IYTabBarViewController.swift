//
//  IYTabBarViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit

class IYTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let activeInvitesController = IYActiveInvitesViewController()
        activeInvitesController.tabBarItem = UITabBarItem(title: "Active Invites", image: UIImage(systemName: "globe"), selectedImage: nil)

        let calendarController = IYCalendarViewController()
        calendarController.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar"), selectedImage: nil)

        let profileController = IYProfileViewController()
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "globe"), selectedImage: nil)

        let detailsController = IYDetailsViewController()
        detailsController.tabBarItem = UITabBarItem(title: "Details", image: UIImage(systemName: "globe"), selectedImage: nil)

        self.setViewControllers([ // Чтобы был NB. Для того, чтобы пушить контроллер. Без NC можно было бы только презентить.
            UINavigationController(rootViewController: activeInvitesController),
            UINavigationController(rootViewController: calendarController),
            UINavigationController(rootViewController: profileController),
            UINavigationController(rootViewController: detailsController)
        ], animated: true)

        self.setTabbarAppearance()
    }

    func setTabbarAppearance() { // настройка TabBar
        self.tabBar.barTintColor = UIColor(named: "backgroundColor") // цвет фона
        self.tabBar.tintColor = UIColor(named: "systemColor") // цвет подписей и иконок (только системных)
        self.tabBar.unselectedItemTintColor = .lightGray // цвет для невыбранных подписей и иконок
        self.tabBar.itemPositioning = .fill // расположение иконок. .fill - по ширине всего ТВ
        //        self.tabBar.isTranslucent = true

        // настройка тени
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -5) // с "-" вверх
        self.tabBar.layer.shadowRadius = 5 // радиус
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowColor = UIColor.black.cgColor // цвет
    }

    // анимация
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = self.tabBar.items?.firstIndex(of: item),
              let imageView = tabBar.subviews[index + 1].subviews.first as? UIImageView else { return }
        // анимация увеличенния картинки
        UIView.animate(withDuration: 0.5, // длительность
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5, // начальная скорость
                       options: .curveEaseInOut) { // прыгает
            imageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4) // трансформируется картинка (увеличивается)
            // анимация в анимации. Возвращаем картинку в исх размер
            UIView.animate(withDuration: 0.5,
                           delay: 0.2, // задержка анимации
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1) // возврат размера
            }
                       }
    }

}

