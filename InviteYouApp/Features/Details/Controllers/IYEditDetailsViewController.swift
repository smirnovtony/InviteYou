//
//  IYEditDetailsViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 12.03.21.
//

import UIKit

class IYEditDetailsViewController: UIViewController {

    //MARK: - var

    private lazy var backgroundColor: UIView = {
        let image = UIView()

        image.backgroundColor = backgroundСolor // добавляем картинку по имени
        image.contentMode = .scaleAspectFill // заполнение картинкой всего вью

        image.translatesAutoresizingMaskIntoConstraints = false // этот флаг обязателен для всех UI элементов

        return image
    }()

    private lazy var registrationLabel: UILabel = {
        let label = UILabel()

        label.text = " Edit Details "
        label.backgroundColor = whiteСolor
        label.textColor = mainСolor// цвет
        label.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        label.layer.cornerRadius = 5
        label.font = fontFamilyBig // шрифт (размер)
        label.textAlignment = .center // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundColor)
        self.view.addSubview(registrationLabel)
//        self.view.addSubview(loginWithLabel)
//
//        self.view.addSubview(appleButton)
//        self.view.addSubview(googleButton)
//        self.view.addSubview(instagramButton)
//        self.view.addSubview(facebookButton)
//
//        self.view.addSubview(userNameLable)
//        self.view.addSubview(userNameField)
//        self.view.addSubview(userPasswordLable)
//        self.view.addSubview(userPasswordField)
//        self.view.addSubview(confirmPasswordLable)
//        self.view.addSubview(confirmPasswordField)
//        self.view.addSubview(emailLable)
//        self.view.addSubview(emailField)

//        self.view.addSubview(registerButton)

        self.setUpConstraintsFunction()

    }

    func setUpConstraintsFunction() {
        self.backgroundColor.snp.updateConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }

        self.registrationLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(80)
//            make.width.equalTo(400)
        }
//
//        self.loginWithLabel.snp.updateConstraints { (make) in
//            make.top.equalTo(self.registrationLabel.snp.bottom).offset(30)
//            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
//        }
//
//
//
//        self.appleButton.snp.updateConstraints { (make) in
//            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(10)
//            make.centerX.equalTo(self.view.safeAreaLayoutGuide).offset(-100)
//            make.height.width.equalTo(30)
//        }
//
//        self.googleButton.snp.updateConstraints { (make) in
//            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(10)
//            make.centerX.equalTo(self.view.safeAreaLayoutGuide).offset(-35)
//            make.height.width.equalTo(30)
//        }
//
//        self.instagramButton.snp.updateConstraints { (make) in
//            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(10)
//            make.centerX.equalTo(self.view.safeAreaLayoutGuide).offset(35)
//            make.height.width.equalTo(30)
//        }
//
//        self.facebookButton.snp.updateConstraints { (make) in
//            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(10)
//            make.centerX.equalTo(self.view.safeAreaLayoutGuide).offset(100)
//            make.height.width.equalTo(30)
//        }
//
//
//
//        self.userNameLable.snp.updateConstraints { (make) in
//            make.top.equalTo(self.appleButton.snp.bottom).offset(30)
//            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(40)
//        }
//
//        self.userNameField.snp.updateConstraints { (make) in
//            make.top.equalTo(self.userNameLable.snp.bottom).offset(10)
//            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(40)
//        }
//
//        self.userPasswordLable.snp.updateConstraints { (make) in
//            make.top.equalTo(self.userNameField.snp.bottom).offset(20)
//            make.left.equalTo(self.view.safeAreaLayoutGuide).inset(40)
//        }
//
//        self.userPasswordField.snp.updateConstraints { (make) in
//            make.top.equalTo(self.userPasswordLable.snp.bottom).offset(10)
//            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(40)
//        }
//
//        self.confirmPasswordLable.snp.updateConstraints { (make) in
//            make.top.equalTo(self.userPasswordField.snp.bottom).offset(20)
//            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(40)
//        }
//
//        self.confirmPasswordField.snp.updateConstraints { (make) in
//            make.top.equalTo(self.confirmPasswordLable.snp.bottom).offset(10)
//            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(40)
//        }
//
//        self.emailLable.snp.updateConstraints { (make) in
//            make.top.equalTo(self.confirmPasswordField.snp.bottom).offset(20)
//            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(40)
//        }
//
//        self.emailField.snp.updateConstraints { (make) in
//            make.top.equalTo(self.emailLable.snp.bottom).offset(10)
//            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(40)
//        }
//
//
//
//
//        self.registerButton.snp.updateConstraints { (make) in
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-50)
//            make.left.right.equalToSuperview().inset(40)
//            make.height.equalTo(60)
//        }
    }




}

