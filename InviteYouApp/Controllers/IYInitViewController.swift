//
//  ViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 10.03.21.
//

import UIKit

class IYInitViewController: UIViewController {

    //MARK: - var Constrait

    private lazy var topAppLabelConstrait: NSLayoutConstraint = self.appLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 250) // задали Constrait в виде локальной переменной

    private lazy var topUserNameLable: NSLayoutConstraint = self.userNameLable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -10)

    private lazy var bottomRegisterButton: NSLayoutConstraint = self.registerButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 50)

    //MARK: - var

    private lazy var backgroundColor: UIView = {
        let image = UIView()

        image.backgroundColor = UIColor(named: "backgroundColor") // добавляем картинку по имени
        image.contentMode = .scaleAspectFill // заполнение картинкой всего вью

        image.translatesAutoresizingMaskIntoConstraints = false // этот флаг обязателен для всех UI элементов

        return image
    }()

    private lazy var appLabel: UILabel = {
        let label = UILabel()

        label.text = "Invite.You"
        label.textColor = .white// цвет
        label.backgroundColor = UIColor(named: "systemColor")
        label.font = fontFamilyBig // шрифт (размер)
        label.textAlignment = .center // выравнивание текста

        label.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        label.layer.cornerRadius = 5

        label.layer.shadowOffset = CGSize(width: 0, height: 5) // с "-" вверх
        label.layer.shadowRadius = 5 // радиус
        label.layer.shadowOpacity = 0.5
        label.layer.shadowColor = UIColor.black.cgColor // цвет

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var userNameLable: UILabel = {
        let label = UILabel()

        label.text = "User Name"
        label.textColor = UIColor(named: "systemColor")// цвет
      
        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .left // выравнивание текста

        label.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        label.layer.cornerRadius = 10

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var userNameField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = .white
        textField.textColor = UIColor(named: "systemColor")
        textField.font = fontFamilyLittle // шрифт (размер)
        textField.borderStyle = .roundedRect // закругление поля
        textField.placeholder = "Enter Your Name"

        textField.clearButtonMode = .always //очистка поля

        textField.layer.shadowOffset = CGSize(width: 0, height: -5) // с "-" вверх
        textField.layer.shadowRadius = 20 // радиус тени
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.black.cgColor // цвет тени

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var userPasswordLable: UILabel = {
        let label = UILabel()

        label.text = "User Password"
        label.textColor = UIColor(named: "systemColor")// цвет

        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .left // выравнивание текста

        label.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        label.layer.cornerRadius = 10

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var userPasswordField: UITextField = {
        let textField = UITextField()

        textField.backgroundColor = .white
        textField.textColor = UIColor(named: "systemColor")
        textField.font = fontFamilyLittle // шрифт (размер)
        textField.borderStyle = .roundedRect // закругление поля
        textField.placeholder = "Enter Password"

        textField.clearButtonMode = .always //очистка поля
        textField.isSecureTextEntry = true //сектерность

        textField.layer.shadowOffset = CGSize(width: 0, height: -5) // с "-" вверх
        textField.layer.shadowRadius = 20 // радиус тени
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowColor = UIColor.black.cgColor // цвет тени

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()

        button.setTitle("Forgot Password?", for: UIControl.State()) // для всех состояний кнопки -> for: UIControl.State()
        button.setTitleColor(UIColor(named: "systemColor"), for: UIControl.State()) // цвет текста
        button.titleLabel?.font = fontFamilyLittle // шрифт (размер)

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var logInButton: UIButton = {
        let button = UIButton()

        button.setTitle("Log In", for: UIControl.State()) // для всех состояний кнопки -> for: UIControl.State()
        button.setTitleColor(.white, for: UIControl.State()) // цвет текста
        button.backgroundColor = UIColor(named: "systemColor")?.withAlphaComponent(1) // цвет кнопки
        button.titleLabel?.font = fontFamilyMiddle // шрифт (размер)
        button.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        button.layer.cornerRadius = 5

        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var dontHaveAnAccountLable: UILabel = {
        let label = UILabel()

        label.text = "Don't Have An Account?"
        label.textColor = UIColor(named: "systemColor")// цвет

        label.font = fontFamilyLittle // шрифт (размер)
        label.textAlignment = .center // выравнивание текста

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()

        button.setTitle("Register", for: UIControl.State()) // для всех состояний кнопки -> for: UIControl.State()
        button.setTitleColor(UIColor(named: "systemColor"), for: UIControl.State()) // цвет текста
        button.backgroundColor = UIColor.white.withAlphaComponent(1) // цвет кнопки
        button.titleLabel?.font = fontFamilyMiddle // шрифт (размер)
        button.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
        button.layer.cornerRadius = 5

        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside) // действие кнопки

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()


        self.view.addSubview(backgroundColor)
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

    }

    //убираем NavigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }



    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // анимация перемещения текста и + self.view.layoutIfNeeded() в UIView.animate см.ниже
        self.topAppLabelConstrait.constant = 40
        self.topUserNameLable.constant = 150
        self.bottomRegisterButton.constant = -100
        self.view.setNeedsUpdateConstraints()

        // анимация вью - выцветание
        UIView.animate(withDuration: 1) { // время withDuration: 1.5
            self.view.layoutIfNeeded() // + анимация перемещения текста
        }
    }

// скрытие клавиатуры
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }

    //MARK: - ButtonTapped

    @objc private func logInButtonTapped() {

        let tabBarController = IYTabBarViewController()

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootViewController(tabBarController)
        }

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)

        // дописать код сохранения данных

    }

    @objc private func registerButtonTapped() {
        let tabBarController = IYRegistrationViewController()

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.changeRootViewController(tabBarController)
        }

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)

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

        self.view.addConstraints([
            topAppLabelConstrait,
//            NSLayoutConstraint(item: self.appLabel, attribute: .top, relatedBy: .equal,
//                               toItem: self.view.safeAreaLayoutGuide, attribute: .top,
//                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.appLabel, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.appLabel, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40),
            NSLayoutConstraint(item: self.appLabel, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 80), //высота
        ])

        self.view.addConstraints([
//            NSLayoutConstraint(item: self.userNameLable, attribute: .top, relatedBy: .equal,
//                               toItem: self.view.safeAreaLayoutGuide, attribute: .top,
//                               multiplier: 1, constant: 150),
            topUserNameLable,
            NSLayoutConstraint(item: self.userNameLable, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.userNameLable, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.userNameField, attribute: .top, relatedBy: .equal,
                               toItem: self.userNameLable, attribute: .bottom,
                               multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.userNameField, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.userNameField, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.userPasswordLable, attribute: .top, relatedBy: .equal,
                               toItem: self.userNameField, attribute: .bottom,
                               multiplier: 1, constant: 30),
            NSLayoutConstraint(item: self.userPasswordLable, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.userPasswordLable, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40)
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.userPasswordField, attribute: .top, relatedBy: .equal,
                               toItem: self.userPasswordLable, attribute: .bottom,
                               multiplier: 1, constant: 20),
            NSLayoutConstraint(item: self.userPasswordField, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.userPasswordField, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40)

        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.forgotPasswordButton, attribute: .top, relatedBy: .equal,
                               toItem: self.userPasswordField, attribute: .bottom,
                               multiplier: 1, constant: 50),
            NSLayoutConstraint(item: self.forgotPasswordButton, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.forgotPasswordButton, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40)
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
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.logInButton, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40),
            NSLayoutConstraint(item: self.logInButton, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 60), //высота
        ])

        self.view.addConstraints([
            NSLayoutConstraint(item: self.dontHaveAnAccountLable, attribute: .bottom, relatedBy: .equal,
                               toItem: self.registerButton, attribute: .top,
                               multiplier: 1, constant: -10),
            NSLayoutConstraint(item: self.dontHaveAnAccountLable, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.dontHaveAnAccountLable, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40)
        ])

        self.view.addConstraints([
            bottomRegisterButton,
//            NSLayoutConstraint(item: self.registerButton, attribute: .bottom, relatedBy: .equal,
//                               toItem: self.view.safeAreaLayoutGuide, attribute: .bottom,
//                               multiplier: 1, constant: -30),
            NSLayoutConstraint(item: self.registerButton, attribute: .left, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .left,
                               multiplier: 1, constant: 40),
            NSLayoutConstraint(item: self.registerButton, attribute: .right, relatedBy: .equal,
                               toItem: self.view.safeAreaLayoutGuide, attribute: .right,
                               multiplier: 1, constant: -40),
            NSLayoutConstraint(item: self.registerButton, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 60) //высота

        ])
    }



}




