//
//  UIStackView+Ex.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 13.04.21.
//

import UIKit

extension UIStackView {
    func addArrangedSubview(_ views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
