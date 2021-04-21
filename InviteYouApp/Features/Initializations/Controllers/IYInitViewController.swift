//
//  ViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit
import SnapKit
import Firebase

class IYInitViewController: IYViewController, UITextFieldDelegate {

    //MARK: - Variables Constrait

    private lazy var topAppLabelConstrait = {
        self.appView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(250)
        }
    }
    private lazy var topUserEmailLabel = {
        self.userEmailLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(-10)
        }
    }
    private lazy var bottomForgotPassButton = {
        self.forgotPasswordButton.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(50)
        }
    }
    private lazy var toplogInButton = {
        self.logInButton.snp.updateConstraints { (make) in
            make.top.equalTo(self.userPasswordField.snp.bottom).offset(40)
        }
    }
    private lazy var bottomRegisterButton = {
        self.registerButton.snp.updateConstraints { (make) in
            make.bottom.equalTo(self.forgotPasswordButton.snp.top).offset(-25)
        }
    }

    //MARK: - Variables

    private var successfulCondition: Bool = false

    private var email: String {
        self.userEmailField.text ?? ""
    }
    private var userPassword: String {
        self.userPasswordField.text ?? ""
    }
    private lazy var appView: UIView = {
        let view = UIView()
        view.backgroundColor = mainСolorBlue
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
    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "User email"
        customLabel(label)
        return label
    }()
    private lazy var userEmailField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.delegate = self
        return textField
    }()
    private lazy var userPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "User password"
        customLabel(label)
        return label
    }()
    private lazy var userPasswordField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorBlue
        customButton(button)
        button.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorBlue
        customButton(button)
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var dontHaveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = mainСolorBlue
        label.font = fontFamilyLittle
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: UIControl.State())
        button.setTitleColor(mainСolorBlue, for: UIControl.State())
        button.backgroundColor = UIColor.white
        customButton(button)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.addSubviews([
            self.appView,
            self.appLabel,
            self.userEmailLabel,
            self.userEmailField,
            self.userPasswordLabel,
            self.userPasswordField,
            self.forgotPasswordButton,
            self.logInButton,
            self.dontHaveAnAccountLabel,
            self.registerButton,
            self.forgotPasswordButton
        ])
        self.setUpConstraintsFunction()
        self.userAlreadylogged()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        constraintsForLittleScreen()
        setUpConstraintsFunction()
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }

    //MARK: - ButtonTapped

    @objc private func logInButtonTapped() {
        if logInConditions() {
            Auth.auth().signIn(withEmail: self.email, password: self.userPassword) { (result, error) in
                if error == nil {
                    self.navigationController?.pushViewController(IYLoadingViewController(), animated: true)
                    UserDefaults.standard.set(true, forKey: "userLoggedBool")
                } else {
                    self.showAlertError()
                }
            }
        } else {
            self.showAlertError()
        }
    }

    @objc private func registerButtonTapped() {
        self.navigationController?.pushViewController(IYRegistrationViewController(), animated: true)
    }

    @objc private func resetPasswordButtonTapped() {
        self.navigationController?.pushViewController(IYResetPasswordViewController(), animated: true)
    }

    private func showAlertError() {
        self.errorAlert(title: "Error", message: "Сheck the entered information")
    }

    private func errorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive)
        self.present(alertController, animated: true)
        alertController.addAction(okAction)
    }

    //MARK: - Methods

    private func userAlreadylogged() {
        if UserDefaults.standard.bool(forKey: "userLoggedBool") == true {
            self.navigationController?.pushViewController(IYLoadingViewController(), animated: true)
        } else {
            self.tabBarController?.tabBar.isHidden = true
        }
    }

    //MARK: - ConstraintsForLittleScreen

    private func constraintsForLittleScreen() {
        let screen = UIScreen.main.bounds
        let screenHeight = screen.size.height
        if screenHeight < 750 {
            self.topAppLabelConstrait = {
                self.appView.snp.updateConstraints { (make) in
                    make.top.equalToSuperview().offset(40)
                }
            }
            self.topUserEmailLabel = {
                self.userEmailLabel.snp.updateConstraints { (make) in
                    make.top.equalToSuperview().offset(140)
                }
            }
            self.bottomForgotPassButton = {
                self.forgotPasswordButton.snp.updateConstraints { (make) in
                    make.bottom.equalToSuperview().inset(30)
                }
            }
        } else {
           self.topAppLabelConstrait = {
                self.appView.snp.updateConstraints { (make) in
                    make.top.equalToSuperview().offset(80)
                }
            }
            self.topUserEmailLabel = {
                self.userEmailLabel.snp.updateConstraints { (make) in
                    make.top.equalToSuperview().offset(200)
                }
            }
            self.bottomForgotPassButton = {
                self.forgotPasswordButton.snp.updateConstraints { (make) in
                    make.bottom.equalToSuperview().inset(60)
                }
            }
            self.toplogInButton = {
                self.logInButton.snp.updateConstraints { (make) in
                    make.top.equalTo(self.userPasswordField.snp.bottom).offset(60)
                }
            }
            self.bottomRegisterButton = {
                self.registerButton.snp.updateConstraints { (make) in
                    make.bottom.equalTo(self.forgotPasswordButton.snp.top).offset(-60)
                }
            }
        }
    }

    //MARK: - LogInConditions

    private func logInConditions() -> Bool {
        var counter = true
        if self.email.isEmpty {
            counter = false
            self.userEmailField.backgroundColor = notСolorPink
        } else {
            successfulCondition = true
        }
        if self.userPassword.isEmpty {
            counter = false
            self.userPasswordField.backgroundColor = notСolorPink
        } else {
            successfulCondition = true
        }
        if counter == false {
            successfulCondition = false
        }
        return successfulCondition
    }

    //MARK: - Constraints

    private func setUpConstraintsFunction() {
        self.appView.snp.makeConstraints { (make) in
            topAppLabelConstrait()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(80)
        }
        self.appLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.appView.snp.center)
        }
        self.userEmailLabel.snp.makeConstraints { (make) in
            topUserEmailLabel()
            make.left.right.equalToSuperview().inset(30)
        }
        self.userEmailField.snp.makeConstraints { (make) in
            make.top.equalTo(self.userEmailLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.userEmailField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(30)
        }
        self.userPasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(30)
        }
        self.logInButton.snp.makeConstraints { (make) in
            toplogInButton()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        self.dontHaveAnAccountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.registerButton.snp.top).offset(10)
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(30)
        }
        self.registerButton.snp.makeConstraints { (make) in
            bottomRegisterButton()
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        self.forgotPasswordButton.snp.makeConstraints { (make) in
            bottomForgotPassButton()
            make.top.equalTo(self.registerButton.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
    }
}
