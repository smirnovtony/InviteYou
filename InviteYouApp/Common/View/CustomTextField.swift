//
//  TextField.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 29.03.21.
//

import UIKit

public func customTextField(_ textField: UITextField) {
    textField.backgroundColor = .white
    textField.textColor = mainСolorBlue
    textField.font = fontFamilyLittle
    textField.borderStyle = .roundedRect
    textField.clearButtonMode = .always
    textField.layer.shadowRadius = 20
    textField.layer.shadowOpacity = 0.5
    textField.layer.shadowColor = UIColor.gray.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
}
