//
//  Button.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 29.03.21.
//

import Foundation
import UIKit

public func customButton(_ button: UIButton) {
    button.titleLabel?.font = fontFamilyMiddle
    button.layer.cornerRadius = 15
    button.layer.shadowColor = UIColor.lightGray.cgColor
    button.layer.shadowOpacity = 5
    button.layer.shadowRadius = 20
    button.clipsToBounds = false
    button.translatesAutoresizingMaskIntoConstraints = false
}
