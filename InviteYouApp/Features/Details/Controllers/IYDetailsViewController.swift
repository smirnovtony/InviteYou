//
//  IYDetailsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//


// это окно красивой инфы
// отсюда по кнопке Edit будет передох на редактирование

import UIKit

class IYDetailsViewController: UIViewController {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(editButtonTapped)) 
        navigationItem.rightBarButtonItem?.tintColor = .white

    }

    
    @objc private func editButtonTapped() {

        let editController = IYEditDetailsViewController()

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootViewController(editController)
        }

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(editController)

    }






}
