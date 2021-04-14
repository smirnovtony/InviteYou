//
//  IYRegistrationStack.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 13.04.21.
//

import UIKit

var registrationStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .equalSpacing
    stack.alignment = .fill
    stack.spacing = 25
    stack.addArrangedSubview([
        userLoginLabel,
        userLoginField,
        userPasswordLabel,
        userPasswordField,
        confirmPasswordLabel,
        confirmPasswordField,
        emailLabel,
        emailField
    ])
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}()
var userLoginLabel: UILabel = {
    let label = UILabel()
    label.text = "User login"
    customLabel(label)
    return label
}()
public var userLoginField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    return textField
}()
var userPasswordLabel: UILabel = {
    let label = UILabel()
    label.text = "User password"
    customLabel(label)
    return label
}()
var userPasswordField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    textField.isSecureTextEntry = true
    return textField
}()
var confirmPasswordLabel: UILabel = {
    let label = UILabel()
    label.text = "Сonfirm password"
    customLabel(label)
    return label
}()
var confirmPasswordField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    textField.isSecureTextEntry = true
    return textField
}()
var emailLabel: UILabel = {
    let label = UILabel()
    label.text = "Email"
    customLabel(label)
    return label
}()
var emailField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    textField.keyboardType = .emailAddress
    textField.autocapitalizationType = UITextAutocapitalizationType.none
    return textField
}()