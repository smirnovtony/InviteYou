//
//  IYCreateInviteStack.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 13.04.21.
//

import UIKit

//MARK: - Variables
var createInviteStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .equalSpacing
    stack.alignment = .fill
    stack.spacing = 25
    stack.addArrangedSubview([
        nameOrganizerLabel,
        nameOrganizerTextField,
        addressLabel,
        addressTextField,
        numberOfPersonsLabel,
        numberOfPersonsTextField,
        typeOfEventLabel,
        typeOfEventTextField,
        nameOfEventLabel,
        nameOfEventTextField
    ])
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}()
var nameOrganizeCreate: String {
    nameOrganizerTextField.text ?? ""
}
var addressCreate: String {
    addressTextField.text ?? ""
}
var numberOfPersonsCreate: String {
    numberOfPersonsTextField.text ?? ""
}
var typeOfEventCreate: String {
    typeOfEventTextField.text ?? ""
}
var nameOfEventCreate: String {
    nameOfEventTextField.text ?? ""
}

var nameOrganizerLabel: UILabel = {
    let label = UILabel()
    label.text = "Name organizer"
    customLabel(label)
    return label
}()
var nameOrganizerTextField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    return textField
}()
var addressLabel: UILabel = {
    let label = UILabel()
    label.text = "Address"
    customLabel(label)
    return label
}()
var addressTextField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    return textField
}()
var numberOfPersonsLabel: UILabel = {
    let label = UILabel()
    label.text = "Persons"
    customLabel(label)
    return label
}()
var numberOfPersonsTextField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    return textField
}()
var numberOfPersonsPicker: UIPickerView = {
     let picker = UIPickerView()
     picker.translatesAutoresizingMaskIntoConstraints = false
     return picker
 }()
var doneToolBar: UIToolbar = {
    let toolbar = UIToolbar()
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    return toolbar
}()
var typeOfEventLabel: UILabel = {
    let label = UILabel()
    label.text = "Type of event"
    customLabel(label)
    return label
}()
var typeOfEventTextField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    return textField
}()
var typeOfEventPicker: UIPickerView = {
    let picker = UIPickerView()
    picker.translatesAutoresizingMaskIntoConstraints = false
    return picker
}()
var nameOfEventLabel: UILabel = {
    let label = UILabel()
    label.text = "Name of event"
    customLabel(label)
    return label
}()
var nameOfEventTextField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    return textField
}()
