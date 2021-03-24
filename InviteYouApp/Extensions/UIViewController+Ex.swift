//
//  File.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 24.03.21.
//
import UIKit

extension UIViewController {
    
    func addTapGestureToHideKeyboard() {
        let theTap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(theTap)
    }

}
