//
//  IYRegistrationViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import SnapKit

class IYRegistrationViewController: IYViewController {

    //MARK: - var

    private var output: Bool = false

    private var userLogin: String {
        self.userLoginField.text ?? ""
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
    private var conditionsPassEqualToLogin: String = "Passwords Must Not Contain Your User Name"
    private var conditionsInvalidPassword: String = "Invalid Password"
    private var conditionsPassCharacters: String = "Password Must Be More Than 8 Characters"

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

    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "apple"), for: .normal)
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "google"), for: .normal)
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "instagram"), for: .normal)
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "facebook"), for: .normal)
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

    private lazy var confirmPasswordLable: UILabel = {
        let label = UILabel()
        label.text = "Сonfirm Password"
        customLable(label)
        return label
    }()

    private lazy var confirmPasswordField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var conditionsPass: UILabel = {
        let label = UILabel()
        label.textColor = notСolorPink
        label.font = fontFamilyLittle?.withSize(18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var conditionsConfirmPass: UILabel = {
        let label = UILabel()
        label.textColor = notСolorPink
        label.font = fontFamilyLittle?.withSize(18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var emailLable: UILabel = {
        let label = UILabel()
        label.text = "Email"
        customLable(label)
        return label
    }()

    private lazy var emailField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
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

        self.mainView.addSubview(self.userLoginLable)
        self.mainView.addSubview(self.userLoginField)
        self.mainView.addSubview(self.userPasswordLable)

        self.mainView.addSubview(self.userPasswordField)
        self.mainView.addSubview(self.confirmPasswordLable)
        self.mainView.addSubview(self.confirmPasswordField)
        self.mainView.addSubview(self.emailLable)
        self.mainView.addSubview(self.emailField)

        self.mainView.addSubview(self.registerButton)
        self.mainView.addSubview(self.backButton)

        self.setUpConstraintsFunction()

        self.emailField.keyboardType = .emailAddress

    }

    // MARK: - ButtonTapped

    @objc private func registerButtonTapped() {

        if registrationConditions() {

            let alertController = UIAlertController(title: "Registration Completed Successfully",
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

            // дописать сохранение данных!!!!!!!!!!!!!!!!!!!!!!

        } else {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Сheck The Entered Information",
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
        var counter = 0
        if !self.userLogin.isEmpty {
            output = true
            self.userLoginField.backgroundColor = .white
        } else {
            counter += 1
            self.userLoginField.backgroundColor = notСolorPink
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
            counter += 1
            conditionsPass.text = conditionsPassEqualToLogin
            conditionsConfirmPass.text = ""
            conditionsUserPassConstraints()
        } else if !self.userPassword.isEmpty,
                  self.userPassword.count < 8 {
                counter += 1
                conditionsPass.text = conditionsPassCharacters
                conditionsConfirmPass.text = ""
                conditionsUserPassConstraints()
        } else if !self.confirmPassword.isEmpty,
                  self.userPassword != self.confirmPassword {
            counter += 1
            userPasswordField.backgroundColor = .white
            conditionsConfirmPass.text = conditionsInvalidPassword
            conditionsPass.text = ""
            conditionsConfirmPassConstraints()
        }
        if self.confirmPassword.isEmpty {
            confirmPasswordField.backgroundColor = notСolorPink
        }
        if self.userPassword.isEmpty {
            userPasswordField.backgroundColor = notСolorPink
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
    private func conditionsUserPassConstraints() {
        userPasswordField.backgroundColor = notСolorPink
        self.mainView.addSubview(self.conditionsPass)
        self.conditionsPass.snp.makeConstraints { (make) in
          make.top.equalTo(self.userPasswordField.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    private func conditionsConfirmPassConstraints() {
        confirmPasswordField.backgroundColor = notСolorPink
        self.mainView.addSubview(self.conditionsConfirmPass)
        self.conditionsConfirmPass.snp.makeConstraints { (make) in
          make.top.equalTo(self.confirmPasswordField.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(30)
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
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-100)
            make.height.width.equalTo(30)
        }
        self.googleButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(-35)
            make.height.width.equalTo(30)
        }
        self.instagramButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(35)
            make.height.width.equalTo(30)
        }
        self.facebookButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview().offset(100)
            make.height.width.equalTo(30)
        }
        self.userLoginLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.appleButton.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(30)
        }
        self.userLoginField.snp.makeConstraints { (make) in
            make.top.equalTo(self.userLoginLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userPasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.userLoginField.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(30)
        }
        self.userPasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.confirmPasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.confirmPasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.confirmPasswordLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.emailLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.confirmPasswordField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        self.emailField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        self.registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailField.snp.bottom).offset(70)
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
