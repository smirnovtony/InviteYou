//
//  IYRegistrationViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import SnapKit
import Firebase

class IYRegistrationViewController: IYViewController, UITextFieldDelegate {
    //MARK: - Variables
    private var output: Bool = false
    private var userLogin: String {
        userLoginField.text ?? ""
    }
    private var userPassword: String {
        userPasswordField.text ?? ""
    }
    private var confirmPassword: String {
        confirmPasswordField.text ?? ""
    }
    private var email: String {
        emailField.text ?? ""
    }
    private var conditionsPassEqualToLogin: String = "Passwords must not contain your user name"
    private var conditionsInvalidPassword: String = "Invalid password"
    private var conditionsPassCharacters: String = "Password must be more than 8 characters"
    private var conditionsEmailCharacters: String = "Check your email"

    private lazy var registrationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.textColor = mainСolorGreen
        label.font = fontFamilyBig
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
    private lazy var conditionsPass: UILabel = {
        let label = UILabel()
        customLabelCondition(label)
        return label
    }()
    private lazy var conditionsConfirmPass: UILabel = {
        let label = UILabel()
        customLabelCondition(label)
        return label
    }()
    private lazy var conditionsEmail: UILabel = {
        let label = UILabel()
        customLabelCondition(label)
        return label
    }()
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorGreen
        customButton(button)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = notСolorPink
        customButton(button)
        button.addTarget(self, action: #selector(backToLoginButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.addSubviews([
            self.registrationView,
            self.registrationLabel,
            self.loginWithLabel,
            loginWithStack,
            registrationStack,
            self.registerButton,
            self.backButton
        ])
        self.setUpConstraintsFunction()
        userLoginField.delegate = self
        userPasswordField.delegate = self
        emailField.delegate = self
    }
    // MARK: - ButtonTapped
    @objc private func registerButtonTapped() {
        if registrationConditions() {
            Auth.auth().createUser(withEmail: email, password: userPassword) { (result, error) in
                if error == nil {
                    if let result = result, !result.user.uid.isEmpty {
                        print(result.user.uid)
                        IYDefault.sh.userLogged = true
                        let reference = Database.database().reference().child("users")
                        reference.child(result.user.uid).updateChildValues(["name": self.userLogin,
                                                                            "email": self.email])

                        let alertController = UIAlertController(title: "Registration completed successfully",
                                                                message: "",
                                                                preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                            let registerController = IYTabBarViewController()
                            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                                sceneDelegate.changeRootViewController(registerController)
                            }
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(registerController)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true)
                    }
                }
            }
        } else {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Сheck the entered information",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive)
                self.present(alertController, animated: true)
                alertController.addAction(okAction)
        }
    }
    @objc private func backToLoginButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    // условия регистрации
    func registrationConditions() -> Bool {
        var counter = true
        if !self.userLogin.isEmpty {
            output = true
            userLoginField.backgroundColor = .white
        } else {
            counter = false
            userLoginField.backgroundColor = notСolorPink
        }
        if !self.userPassword.isEmpty,
           !self.confirmPassword.isEmpty,
           self.userPassword.count >= 8,
           self.userPassword != self.userLogin,
           self.userPassword == self.confirmPassword {
            output = true
            conditionsPass.text = ""
            conditionsConfirmPass.text = ""
            userPasswordField.backgroundColor = .white
            confirmPasswordField.backgroundColor = .white
        } else if !self.userPassword.isEmpty,
                  self.userPassword == self.userLogin {
            counter = false
            conditionsPass.text = conditionsPassEqualToLogin
            conditionsConfirmPass.text = ""
            conditionsUserPassConstraints()
        } else if !self.userPassword.isEmpty,
                  self.userPassword.count < 8 {
                counter = false
                conditionsPass.text = conditionsPassCharacters
                conditionsConfirmPass.text = ""
                conditionsUserPassConstraints()
        } else if !self.confirmPassword.isEmpty,
                  self.userPassword != self.confirmPassword {
            counter = false
            userPasswordField.backgroundColor = .white
            conditionsConfirmPass.text = conditionsInvalidPassword
            conditionsPass.text = ""
            conditionsConfirmPassConstraints()
        }
        if !self.email.isEmpty, isValid(email) {
            output = true
            emailField.backgroundColor = .white
            conditionsEmail.text = ""
        } else if self.email.isEmpty {
            emailField.backgroundColor = notСolorPink
        } else {
            counter = false
            conditionsEmail.text = conditionsEmailCharacters
            conditionsEmailConstraints()
        }
        if self.confirmPassword.isEmpty {
            confirmPasswordField.backgroundColor = notСolorPink
        }
        if self.userPassword.isEmpty {
            userPasswordField.backgroundColor = notСolorPink
        }
        if counter == false {
            output = false
        }
        return output
    }
    private func conditionsUserPassConstraints() {
        userPasswordField.backgroundColor = notСolorPink
        self.mainView.addSubview(conditionsPass)
        conditionsPass.snp.makeConstraints { (make) in
            make.top.equalTo(userPasswordField.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    private func conditionsConfirmPassConstraints() {
        confirmPasswordField.backgroundColor = notСolorPink
        self.mainView.addSubview(conditionsConfirmPass)
        conditionsConfirmPass.snp.makeConstraints { (make) in
            make.top.equalTo(confirmPasswordField.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    private func conditionsEmailConstraints() {
        emailField.backgroundColor = notСolorPink
        self.mainView.addSubview(conditionsEmail)
        conditionsEmail.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    private func isValid(_ email: String) -> Bool {
        // swiftlint:disable line_length
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
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
        loginWithStack.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(60)
        }
        registrationStack.snp.makeConstraints { (make) in
            make.top.equalTo(loginWithStack.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
                }
        self.registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(registrationStack.snp.bottom).offset(50)
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(30)
        }
        self.backButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.registerButton.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
