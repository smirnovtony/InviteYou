//
//  IYTabBarViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit

class IYTabBarViewController: UITabBarController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let activeInvitesController = IYActiveInvitesViewController()
        activeInvitesController.tabBarItem = UITabBarItem(title: "My invites", image: UIImage(systemName: "house"), selectedImage: nil)

        let searchController = IYSearchViewController()
        searchController.tabBarItem = UITabBarItem(title: "Open invites", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)

        let profileController = IYProfileViewController()
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)

        self.setViewControllers([
            UINavigationController(rootViewController: activeInvitesController),
            UINavigationController(rootViewController: searchController),
            UINavigationController(rootViewController: profileController)
        ], animated: true)

        self.setTabbarAppearance()
    }
    //MARK: - TabBar
    func setTabbarAppearance() {
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = mainСolorBlue
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.itemPositioning = .fill
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: fontFamilyLittle?.withSize(15) ?? UIFont.systemFont(ofSize: 15)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: fontFamilyLittle?.withSize(15) ?? UIFont.systemFont(ofSize: 15)], for: .selected)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = self.tabBar.items?.firstIndex(of: item),
              let imageView = tabBar.subviews[index + 1].subviews.first as? UIImageView else { return }
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut) {
            imageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)

            UIView.animate(withDuration: 0.5,
                           delay: 0.2,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
                       }
    }

}
