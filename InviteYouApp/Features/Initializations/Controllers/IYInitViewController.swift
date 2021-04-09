//
//  ViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import SnapKit

class IYInitViewController: UIViewController {

    //MARK: - Variables Constrait

    private lazy var topAppLabelConstrait: NSLayoutConstraint = self.appView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 250) // задали Constrait в виде локальной переменной

    private lazy var topUserNameLable: NSLayoutConstraint = self.userLoginLable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -10)

    private lazy var bottomRegisterButton: NSLayoutConstraint = self.registerButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 50)

    //MARK: - Variables

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

    private lazy var userLoginLable: UILabel = {
        let label = UILabel()
        label.text = "User Login"
        customLable(label)
        return label
    }()

    private lazy var userLoginField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        return textField
    }()

    private lazy var userPasswordLable: UILabel = {
        let label = UILabel()
        label.text = "User Password"
        customLable(label)
        return label
    }()

    private lazy var userPasswordField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.isSecureTextEntry = true
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
        customButton(button)
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
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
        customButton(button)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToHideKeyboard()
        self.view.backgroundColor = backgroundСolorWhite

        self.view.addSubview(appView)
        self.view.addSubview(appLabel)
        self.view.addSubview(userLoginLable)
        self.view.addSubview(userLoginField)
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
                               multiplier: 1, constant: 80)
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
            NSLayoutConstraint(item: self.userLoginLable, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.userLoginLable, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.userLoginField, attribute: .top, relatedBy: .equal,
                               toItem: self.userLoginLable, attribute: .bottom,
                               multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.userLoginField, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.userLoginField, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -30)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.userPasswordLable, attribute: .top, relatedBy: .equal,
                               toItem: self.userLoginField, attribute: .bottom,
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
                               multiplier: 1, constant: 60)
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
