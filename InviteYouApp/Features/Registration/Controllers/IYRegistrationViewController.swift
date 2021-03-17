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

    private var falseColor = UIColor(named: "falseColor")?.withAlphaComponent(0.2)

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

    private lazy var registrationLabel: UILabel = {
        let label = UILabel()

        label.text = " Registration "
        label.backgroundColor = whiteСolor
        label.textColor = mainСolor// цвет
        label.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        label.layer.cornerRadius = 5
        label.font = fontFamilyBig // шрифт (размер)
        label.textAlignment = .center // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var loginWithLabel: UILabel = {
        let label = UILabel()

        label.text = "Login With"
        label.textColor = mainСolor// цвет
        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .center // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"apple"), for: .normal)
        //        сделать картинку Apple button.
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside) // действие кнопки
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"google"), for: .normal)  //!!!!!!!!изменить имя значка
        //        сделать картинку google button.
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside) // действие кнопки
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"instagram"), for: .normal)
        //        сделать картинку instagram button.
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside) // действие кнопки
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"facebook"), for: .normal)  //!!!!!!!!изменить имя значка
        //        сделать картинку facebook button.
        //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside) // действие кнопки
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var userNameLable: UILabel = {
        let label = UILabel()

        label.text = "User Name"
        label.textColor = mainСolor// цвет

        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .left // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var userNameField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = whiteСolor
        textField.textColor = mainСolor
        textField.font = fontFamilyLittle // шрифт (размер)
        textField.borderStyle = .roundedRect // закругление поля
        textField.placeholder = "Enter Your Name"

        textField.clearButtonMode = .always //очистка поля

        textField.layer.shadowOffset = CGSize(width: 0, height: -5) // с "-" вверх
        textField.layer.shadowRadius = 20 // радиус тени
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor // цвет тени

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var userPasswordLable: UILabel = {
        let label = UILabel()

        label.text = "User Password"
        label.textColor = mainСolor// цвет

        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .left // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var userPasswordField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = whiteСolor
        textField.textColor = mainСolor
        textField.font = fontFamilyLittle // шрифт (размер)
        textField.borderStyle = .roundedRect // закругление поля
        textField.placeholder = "Enter Password"

        textField.clearButtonMode = .always //очистка поля
        textField.isSecureTextEntry = true //сектерность

        textField.layer.shadowOffset = CGSize(width: 0, height: -5) // с "-" вверх
        textField.layer.shadowRadius = 20 // радиус тени
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor // цвет тени

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var confirmPasswordLable: UILabel = {
        let label = UILabel()

        label.text = "Сonfirm Password"
        label.textColor = mainСolor// цвет

        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .left // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var confirmPasswordField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = whiteСolor
        textField.textColor = mainСolor
        textField.font = fontFamilyLittle // шрифт (размер)
        textField.borderStyle = .roundedRect // закругление поля
        textField.placeholder = "Сonfirm Password"

        textField.clearButtonMode = .always //очистка поля
        textField.isSecureTextEntry = true //сектерность

        textField.layer.shadowOffset = CGSize(width: 0, height: -5) // с "-" вверх
        textField.layer.shadowRadius = 20 // радиус тени
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor // цвет тени

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var emailLable: UILabel = {
        let label = UILabel()

        label.text = "Email"
        label.textColor = mainСolor// цвет

        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .left // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var emailField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = whiteСolor
        textField.textColor = mainСolor
        textField.font = fontFamilyLittle // шрифт (размер)
        textField.borderStyle = .roundedRect // закругление поля
        textField.placeholder = "Enter Your Email adress"

        textField.clearButtonMode = .always //очистка поля

        textField.layer.shadowOffset = CGSize(width: 0, height: -5) // с "-" вверх
        textField.layer.shadowRadius = 20 // радиус тени
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.gray.cgColor // цвет тени

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()

        button.setTitle("Register", for: UIControl.State()) // для всех состояний кнопки -> for: UIControl.State()
        button.setTitleColor(whiteСolor, for: UIControl.State()) // цвет текста
        button.backgroundColor = mainСolor?.withAlphaComponent(1) // цвет кнопки
        button.titleLabel?.font = fontFamilyMiddle // шрифт (размер)
        button.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        button.layer.cornerRadius = 5

        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var backToLoginButton: UIButton = {
        let button = UIButton()

        button.setTitle("Back", for: UIControl.State()) // для всех состояний кнопки -> for: UIControl.State()
        button.setTitleColor(mainСolor?.withAlphaComponent(1), for: UIControl.State()) // цвет текста
        button.backgroundColor = whiteСolor // цвет кнопки
        button.titleLabel?.font = fontFamilyMiddle // шрифт (размер)
        button.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        button.layer.cornerRadius = 5

        button.addTarget(self, action: #selector(backToLoginButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()


    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.mainView.backgroundColor = backgroundСolor

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
        self.mainView.addSubview(self.backToLoginButton)

        self.setUpConstraintsFunction()

        self.emailField.keyboardType = .emailAddress // клавиатера для email
    }

    // MARK: - textField

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
    }

    // MARK: - ButtonTapped

    @objc private func registerButtonTapped() {

        if registrationConditions() {

            let registerController = IYTabBarViewController()

            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.changeRootViewController(registerController)
            }

            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(registerController)
        
        // дописать сохранение данных!!!!!!!!
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
        } else {
            counter += 1
            self.userNameField.backgroundColor = falseColor
        }

        if !self.userPassword.isEmpty {
//               , self.userPassword.count > 10
            output = true
        } else {
            counter += 1
            self.userPasswordField.backgroundColor = falseColor

        }

        if !self.confirmPassword.isEmpty, self.userPassword == self.confirmPassword {
            //               , self.userPassword.count > 10
            output = true
        } else {
            counter += 1
            self.confirmPasswordField.backgroundColor = falseColor
        }

        if !self.email.isEmpty {
            output = true
        } else {
            counter += 1
            self.emailField.backgroundColor = falseColor
        }

        if counter > 0 {
            output = false
        }

        return output
    }

    //MARK: - Constraints

    func setUpConstraintsFunction() {
        self.registrationLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        self.loginWithLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.registrationLabel.snp.bottom).offset(30)
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
            make.left.equalToSuperview().inset(40)
        }
        self.userNameField.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.userPasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(40)
        }
        self.userPasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.confirmPasswordLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.userPasswordField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
        }
        self.confirmPasswordField.snp.makeConstraints { (make) in
            make.top.equalTo(self.confirmPasswordLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
        }
        self.emailLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.confirmPasswordField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
        }
        self.emailField.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailLable.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
//            make.bottom.greaterThanOrEqualTo(self.registerButton.snp.top).offset(-50)
        }
        self.registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.emailField.snp.bottom).offset(50)
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(40)
//            make.bottom.greaterThanOrEqualTo(self.registerButton.snp.top).offset(-50)
        }
        self.backToLoginButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.registerButton.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(60)
//            make.bottom.lessThanOrEqualTo((self.view.safeAreaLayoutGuide.snp.bottom).inset(50))
            make.bottom.equalToSuperview().inset(50)
        }
//        self.registerButton.setContentHuggingPriority(UILayoutPriority(rawValue: 5), for: .vertical)
//        self.emailField.setContentHuggingPriority(UILayoutPriority(rawValue: 999), for: .vertical)
//        self.registerButton.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: .vertical)
//        self.emailField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
    }

}
