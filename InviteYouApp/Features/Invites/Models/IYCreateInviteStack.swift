//
//  IYCreateInviteStack.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 13.04.21.
//

import UIKit

var createInviteStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .equalSpacing
    stack.alignment = .fill
    stack.spacing = 25
    stack.addArrangedSubview([
        nameOrganizerLabel,
        nameOrganizerTextField,
        infoAboutOrganizerLabel,
        infoAboutOrganizerTextField,
        addressLabel,
        addressTextField,
        numberOfPersonsLabel,
        numberOfPersonsTextField,
        typeOfEventLabel,
        typeOfEventTextField,
        nameOfEventLabel,
        nameOfEventTextField,
        infoAboutEventLabel,
        infoAboutEventTextView
    ])
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}()
//MARK: - Variables
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
private var infoAboutOrganizerLabel: UILabel = {
    let label = UILabel()
    label.text = "Info about the organizer"
    customLabel(label)
    return label
}()
var infoAboutOrganizerTextField: UITextField = {
    let textField = UITextField()
    customTextField(textField)
    return textField
}()
var addressLabel: UILabel = { // связать с картой!!!!!!!!!!!!!!!!!!!!!!!!!!
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
var infoAboutEventLabel: UILabel = {
    let label = UILabel()
    label.text = "Info about event"
    customLabel(label)
    return label
}()
var infoAboutEventTextView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .white
    textView.sizeToFit()
    textView.isScrollEnabled = false
    textView.font = fontFamilyLittle
    textView.textColor = mainСolorGreen
    textView.snp.makeConstraints { (make) in
        make.height.equalTo(80)
    }
    return textView
}()
