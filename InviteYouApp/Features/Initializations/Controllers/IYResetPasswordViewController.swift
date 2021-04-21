//
//  IYChangePasswordViewController.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 28.03.21.
//

import UIKit
import Firebase

class IYResetPasswordViewController: IYViewController {

    //MARK: - Variables

    private var successfulCondition: Bool = false

    private var oldPassword: String {
        emailField.text ?? ""
    }
    private lazy var resetPassView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.gray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var resetPassLabel: UILabel = {
        let label = UILabel()
        label.text = "Reset password"
        label.textColor = mainСolorBlue
        label.font = fontFamilyBig
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var changePasswordStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 25
        stack.addArrangedSubview([
            self.emailLabel,
            self.emailField
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        customLabel(label)
        return label
    }()
    private lazy var emailField: UITextField = {
        let textField = UITextField()
        customTextField(textField)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        return textField
    }()
    private lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.backgroundColor = mainСolorBlue
        customButton(button)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
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
            self.resetPassView,
            self.resetPassLabel,
            self.changePasswordStack,
            self.resetButton,
            self.backButton
        ])
        self.setUpConstraintsFunction()
    }

    // MARK: - ButtonTapped

    @objc private func resetButtonTapped() {
        let email = emailField.text ?? ""
        if !email.isEmpty {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error == nil {
                    self.errorAllert(title: "Password reset successfully!", message: "")
                } else {
                    self.errorAllert(title: "Error", message: "Сheck entered email adress")
                }
            }
        }
    }

    private func errorAllert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive)
        self.present(alertController, animated: true)
        alertController.addAction(okAction)
    }

    @objc private func backToLoginButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Constraints

    private func setUpConstraintsFunction() {
        self.resetPassView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(80)
        }
        self.resetPassLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.resetPassView.snp.center)
        }
        self.changePasswordStack.snp.makeConstraints { (make) in
            make.top.equalTo(self.resetPassLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(30)
        }
        self.resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.changePasswordStack.snp.bottom).offset(70)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        self.backButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.resetButton.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(50)
        }
    }
}
