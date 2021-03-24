//
//  ViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import SnapKit

class IYInitViewController: UIViewController {

    //MARK: - var Constrait

    private lazy var topAppLabelConstrait: NSLayoutConstraint = self.appView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 250) // задали Constrait в виде локальной переменной

    private lazy var topUserNameLable: NSLayoutConstraint = self.userNameLable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -10)

    private lazy var bottomRegisterButton: NSLayoutConstraint = self.registerButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 50)

    //MARK: - var

    private lazy var appView: UIView = {
        let view = UIView()

        view.backgroundColor = mainСolorGreen
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.5

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var appLabel: UILabel = {
        let label = UILabel()

        label.text = "Invite.You"
        label.textColor = .white
        label.font = fontFamilyBig
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var userNameLable: UILabel = {
        let label = UILabel()

        label.text = "User Name"
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .left

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var userNameField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = .white
        textField.textColor = mainСolorGreen
        textField.font = fontFamilyLittle
        textField.borderStyle = .roundedRect
//        textField.placeholder = "Enter Your Name"
        textField.clearButtonMode = .always
        textField.layer.shadowRadius = 20
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var userPasswordLable: UILabel = {
        let label = UILabel()

        label.text = "User Password"
        label.textColor = mainСolorGreen

        label.font = fontFamilyLittle
        label.textAlignment = .left

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var userPasswordField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = .white
        textField.textColor = mainСolorGreen
        textField.font = fontFamilyLittle
        textField.borderStyle = .roundedRect
//        textField.placeholder = "Enter Password"
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        textField.layer.shadowRadius = 20
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()

        button.setTitle("Forgot Password?", for: UIControl.State())
        button.setTitleColor(mainСolorGreen, for: UIControl.State())
        button.titleLabel?.font = fontFamilyLittle

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()

        button.setTitle("Log In", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorGreen?.withAlphaComponent(1)
        button.titleLabel?.font = fontFamilyMiddle
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 20
        button.clipsToBounds = false

        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var dontHaveAnAccountLable: UILabel = {
        let label = UILabel()

        label.text = "Don't Have An Account?"
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()

        button.setTitle("Register", for: UIControl.State())
        button.setTitleColor(mainСolorGreen, for: UIControl.State())
        button.backgroundColor = UIColor.white.withAlphaComponent(1)
        button.titleLabel?.font = fontFamilyMiddle
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 5
        button.layer.shadowRadius = 20
        button.clipsToBounds = false

        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        
        self.view.backgroundColor = backgroundСolorWhite

        self.view.addSubview(appView)
        self.view.addSubview(appLabel)
        self.view.addSubview(userNameLable)
        self.view.addSubview(userNameField)
        self.view.addSubview(userPasswordLable)
        self.view.addSubview(userPasswordField)
        self.view.addSubview(forgotPasswordButton)
        self.view.addSubview(logInButton)
        self.view.addSubview(dontHaveAnAccountLable)
        self.view.addSubview(registerButton)
        
        self.setUpConstraintsFunction()

        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.topAppLabelConstrait.constant = 30
        self.topUserNameLable.constant = 150
        self.bottomRegisterButton.constant = -100
        setUpConstraintsFunction()

        UIView.animate(withDuration: 1) { 
            self.view.layoutIfNeeded()
        }
    }

    //MARK: - ButtonTapped

    @objc private func logInButtonTapped() {

        let tabBarController = IYTabBarViewController()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)

        // дописать код сохранения данных!!!!!!!!!!!!!!!!

    }

    @objc private func registerButtonTapped() {
        self.navigationController?.pushViewController(IYRegistrationViewController(), animated: true)
    }

    //MARK: - Constraints
    
    func setUpConstraintsFunction() {
        self.view.addConstraints([
            topAppLabelConstrait,
//            NSLayoutConstraint(item: self.appLabel, attribute: .top, relatedBy: .equal,
//                               toItem: self.view.safeAreaLayoutGuide, attribute: .top,
//                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.appView, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.appView, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30),
            NSLayoutConstraint(item: self.appView, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 80), //высота
        ])
        
        self.view.addConstraints([
            NSLayoutConstraint(item: self.appLabel, attribute: .centerX, relatedBy: .equal,
                               toItem: self.appView, attribute: .centerX,
                               multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self.appLabel, attribute: .centerY, relatedBy: .equal,
                               toItem: self.appView, attribute: .centerY,
                               multiplier: 1, constant: 0)
        ])

        self.view.addConstraints([
//            NSLayoutConstraint(item: self.userNameLable, attribute: .top, relatedBy: .equal,
//                               toItem: self.view.safeAreaLayoutGuide, attribute: .top,
//                               multiplier: 1, constant: 150),
            topUserNameLable,
            NSLayoutConstraint(item: self.userNameLable, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.userNameLable, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.userNameField, attribute: .top, relatedBy: .equal,
                               toItem: self.userNameLable, attribute: .bottom,
                               multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.userNameField, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.userNameField, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.userPasswordLable, attribute: .top, relatedBy: .equal,
                               toItem: self.userNameField, attribute: .bottom,
                               multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.userPasswordLable, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.userPasswordLable, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.userPasswordField, attribute: .top, relatedBy: .equal,
                               toItem: self.userPasswordLable, attribute: .bottom,
                               multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.userPasswordField, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.userPasswordField, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30)

        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.forgotPasswordButton, attribute: .top, relatedBy: .equal,
                               toItem: self.userPasswordField, attribute: .bottom,
                               multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.forgotPasswordButton, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.forgotPasswordButton, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30)
//            NSLayoutConstraint(item: self.forgotPasswordButton, attribute: .right, relatedBy: .greaterThanOrEqual,
//                               toItem: self.userPasswordField, attribute: .right,
//                               multiplier: 1, constant: -40)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.logInButton, attribute: .top, relatedBy: .equal,
                               toItem: self.forgotPasswordButton, attribute: .bottom,
                               multiplier: 1, constant: 10),
            NSLayoutConstraint(item: self.logInButton, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.logInButton, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30),
            NSLayoutConstraint(item: self.logInButton, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 60), //высота
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.dontHaveAnAccountLable, attribute: .bottom, relatedBy: .equal,
                               toItem: self.registerButton, attribute: .top,
                               multiplier: 1, constant: -20),
            NSLayoutConstraint(item: self.dontHaveAnAccountLable, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.dontHaveAnAccountLable, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30)
        ])

        self.view.addConstraints([
            bottomRegisterButton,
//            NSLayoutConstraint(item: self.registerButton, attribute: .bottom, relatedBy: .equal,
//                               toItem: self.view.safeAreaLayoutGuide, attribute: .bottom,
//                               multiplier: 1, constant: -30),
            NSLayoutConstraint(item: self.registerButton, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.registerButton, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30),
            NSLayoutConstraint(item: self.registerButton, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 60) //высота

        ])

    }



}




