//
//  IYRegistrationViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//



//ХЗ почему так с цветом




import UIKit

class IYRegistrationViewController: UIViewController {

    //MARK: - var
    private lazy var backgroundColor: UIView = {
        let image = UIView()

        image.backgroundColor = UIColor(named: "backgroundColor") // добавляем картинку по имени
        image.contentMode = .scaleAspectFill // заполнение картинкой всего вью

        image.translatesAutoresizingMaskIntoConstraints = false // этот флаг обязателен для всех UI элементов

        return image
    }()

    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(backgroundColor)
//        self.view.backgroundColor = .white
    }

    //MARK: - Constraints

    func setUpConstraintsFunction() {
        self.view.addConstraints([
            NSLayoutConstraint(item: self.backgroundColor, attribute: .top, relatedBy: .equal,
                               toItem: self.view, attribute: .top,
                               multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.backgroundColor, attribute: .left, relatedBy: .equal,
                               toItem: self.view, attribute: .left,
                               multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.backgroundColor, attribute: .right, relatedBy: .equal,
                               toItem: self.view, attribute: .right,
                               multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.backgroundColor, attribute: .bottom, relatedBy: .equal,
                               toItem: self.view, attribute: .bottom,
                               multiplier: 1, constant: 0)
        ])
    }
}
