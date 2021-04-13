//
//  IYLoginWithStack.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 13.04.21.
//

import UIKit

var loginWithStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.distribution = .equalSpacing
    stack.alignment = .center
    stack.spacing = 25
    stack.addArrangedSubview([
        appleButton,
        googleButton,
        instagramButton,
        facebookButton
    ])
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}()

private func loginWithButton(_ button: UIButton) {
    button.snp.makeConstraints { (make) in
        make.width.height.equalTo(40)
    }
    button.translatesAutoresizingMaskIntoConstraints = false
}
var appleButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "apple"), for: .normal)
    loginWithButton(button)
    //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    return button
}()
var googleButton: UIButton = {
    let button = UIButton()
    loginWithButton(button)
    button.setImage(UIImage(named: "google"), for: .normal)
    //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)

    return button
}()
var instagramButton: UIButton = {
    let button = UIButton()
    loginWithButton(button)
    button.setImage(UIImage(named: "instagram"), for: .normal)
    //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    return button
}()
var facebookButton: UIButton = {
    let button = UIButton()
    loginWithButton(button)
    button.setImage(UIImage(named: "facebook"), for: .normal)
    //        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    return button
}()
