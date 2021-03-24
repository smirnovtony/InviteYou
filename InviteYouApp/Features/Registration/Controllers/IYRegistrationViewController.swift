//
//  IYRegistrationViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import SnapKit

class IYRegistrationViewController: IYViewController{

    //MARK: - var

    private var output: Bool = false

    private var userName: String {
        self.userNameField.text ?? ""
    }

    private var userPassword: String {
        self.userPasswordField.text ?? ""
    }

    private var confirmPassword: String {
        self.confirmPasswordField.text ?? ""
    }

    private var email: String {
        self.emailField.text ?? ""
    }

    private lazy var registrationView: UIView = {
        let view = UIView()

        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 20 // радиус
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.gray.cgColor

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var registrationLabel: UILabel = {
        let label = UILabel()

        label.text = "Registration"
        label.textColor = mainСolorGreen
        label.font = fontFamilyBig?.withSize(47)
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var loginWithLabel: UILabel = {
        let label = UILabel()

        label.text = "Login With"
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"apple"), for: .normal)
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"google"), for: .normal)
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"instagram"), for: .normal)
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"facebook"), for: .normal)
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
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

    private lazy var conditionsUserNamePasswordLable: UILabel = {
        let label = UILabel()

        label.text = "Passwords must not contain your User Name"
        label.textColor = notСolorPink?.withAlphaComponent(5)
        label.font = fontFamilyLittle?.withSize(15)
        label.textAlignment = .right

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var conditionsPasswordLable: UILabel = {
        let label = UILabel()

        label.text = "Password must be more than 8 characters"
        label.textColor = notСolorPink?.withAlphaComponent(5)
        label.font = fontFamilyLittle?.withSize(15)
        label.textAlignment = .right

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var confirmPasswordLable: UILabel = {
        let label = UILabel()

        label.text = "Сonfirm Password"
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .left

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var confirmPasswordField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = .white
        textField.textColor = mainСolorGreen
        textField.font = fontFamilyLittle
        textField.borderStyle = .roundedRect
//        textField.placeholder = "Сonfirm Password"
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        textField.layer.shadowRadius = 20
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var conditionsConfirmPasswordLable: UILabel = {
        let label = UILabel()

        label.text = "Invalid password"
        label.textColor = notСolorPink?.withAlphaComponent(5)
        label.font = fontFamilyLittle?.withSize(15)
        label.textAlignment = .right

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var emailLable: UILabel = {
        let label = UILabel()

        label.text = "Email"
        label.textColor = mainСolorGreen
        label.font = fontFamilyLittle
        label.textAlignment = .left

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var emailField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = .white
        textField.textColor = mainСolorGreen
        textField.font = fontFamilyLittle
        textField.borderStyle = .roundedRect // закругление поля
//        textField.placeholder = "Enter Your Email adress"
        textField.clearButtonMode = .always
        textField.layer.shadowRadius = 20
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()

        button.setTitle("Register", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorGreen?.withAlphaComponent(1)
        button.titleLabel?.font = fontFamilyMiddle
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 20
        button.clipsToBounds = false

        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)


        button.translatesAutoresizingMaskIntoConstraints = false


        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()

        button.setTitle("Back", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = notСolorPink
        button.titleLabel?.font = fontFamilyMiddle
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 20
        button.clipsToBounds = false

        button.addTarget(self, action: #selector(backToLoginButtonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()


    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addTapGestureToHideKeyboard()

        self.mainView.addSubview(self.registrationView)
        self.mainView.addSubview(self.registrationLabel)
        self.mainView.addSubview(self.loginWithLabel)

        self.mainView.addSubview(self.appleButton)
        self.mainView.addSubview(self.googleButton)
        self.mainView.addSubview(self.instagramButton)
        self.mainView.addSubview(self.facebookButton)

        self.mainView.addSubview(self.userNameLable)
        self.mainView.addSubview(self.userNameField)
        self.mainView.addSubview(self.userPasswordLable)

        self.mainView.addSubview(self.userPasswordField)
        self.mainView.addSubview(self.confirmPasswordLable)
        self.mainView.addSubview(self.confirmPasswordField)
        self.mainView.addSubview(self.emailLable)
        self.mainView.addSubview(self.emailField)

        self.mainView.addSubview(self.registerButton)
        self.mainView.addSubview(self.backButton)

        self.setUpConstraintsFunction()

        self.emailField.keyboardType = .emailAddress // клавиатера для email


    }

    // MARK: - ButtonTapped

    @objc private func registerButtonTapped() {

        if registrationConditions() {

            let alertController = UIAlertController(title: "Registration completed successfully", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                let registerController = IYTabBarViewController()
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.changeRootViewController(registerController)
                }
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(registerController)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true)

            // дописать сохранение данных!!!!!!!!!!!!!!!!!!!!!!

        } else {
            let alertController = UIAlertController(title: "Error", message: "Сheck the entered information", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive) { _ in
                        print("Error action tapped")
                    }
                self.present(alertController, animated: true)
                alertController.addAction(okAction)
        }
    }

    @objc private func backToLoginButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }


    // условия регистрации
    func registrationConditions() -> Bool {
        var counter = 0
        if !self.userName.isEmpty {
            output = true
            self.userNameField.backgroundColor = .white
        } else {
            counter += 1
            self.userNameField.backgroundColor = notСolorPink
        }
        if !self.userPassword.isEmpty, self.userPassword.count >= 8, self.userPassword != self.userName {
            output = true
            self.userPasswordField.backgroundColor = .white
            conditionsPasswordLable.textColor = backgroundСolorWhite
            conditionsUserNamePasswordLable.textColor = backgroundСolorWhite
        } else if self.userPassword == self.userName {
            counter += 1
            conditionsUserNamePassword()
            self.userPasswordField.backgroundColor = notСolorPink
            self.confirmPasswordField.backgroundColor = notСolorPink
        } else {
            counter += 1
            conditionsPassword()
            self.userPasswordField.backgroundColor = notСolorPink
            self.confirmPasswordField.backgroundColor = notСolorPink
        }
        if !self.confirmPassword.isEmpty, self.userPassword == self.confirmPassword, self.userPassword.count >= 8, self.userPassword != self.userName {
            output = true
            conditionsConfirmPasswordLable.textColor = backgroundСolorWhite
            self.confirmPasswordField.backgroundColor = .white
        } else if !self.confirmPassword.isEmpty, self.userPassword == self.confirmPassword {
            counter += 1
            self.confirmPasswordField.backgroundColor = notСolorPink
            self.userPasswordField.backgroundColor = notСolorPink
        } else {
            counter += 1
            conditionsConfirmPassword()
            self.confirmPasswordField.backgroundColor = notСolorPink
        }
        if !self.email.isEmpty {
            output = true
            self.emailField.backgroundColor = .white
        } else {
            counter += 1
            self.emailField.backgroundColor = notСolorPink
        }
        if counter > 0 {
            output = false
        }
        return output
    }

    private func conditionsPassword() { // более 8 символов
        self.mainView.addSubview(self.conditionsPasswordLable)

        self.conditionsPasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordField.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(30)
        }
    }
    private func conditionsUserNamePassword() { // не совпадает с UserName
        self.mainView.addSubview(self.conditionsUserNamePasswordLable)

        self.conditionsUserNamePasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordField.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(30)
        }
    }

    private func conditionsConfirmPassword() { // более 8 символов в подтверждении пароля
        self.mainView.addSubview(self.conditionsConfirmPasswordLable)

        self.conditionsConfirmPasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.confirmPasswordField.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(30)
        }
    }

    //MARK: - Constraints

    func setUpConstraintsFunction() {
        self.registrationView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(80)
        }
        self.registrationLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.registrationView.snp.centerX)
            make.centerY.equalTo(self.registrationView.snp.centerY)
        }
        self.loginWithLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.registrationLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        self.appleButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(-100)
            make.height.width.equalTo(30)
        }
        self.googleButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(-35)
            make.height.width.equalTo(30)
        }
        self.instagramButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(35)
            make.height.width.equalTo(30)
        }
        self.facebookButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(100)
            make.height.width.equalTo(30)
        }
        self.userNameLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.appleButton.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(30)
        }
        self.userNameField.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userPasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(30)
        }
        self.userPasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.confirmPasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(30)
        }
        self.confirmPasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.confirmPasswordLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.emailLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.confirmPasswordField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(30)
        }
        self.emailField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailField.snp.bottom).offset(50)
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(30)
        }
        self.backButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.registerButton.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(50)
        }
    }

}
