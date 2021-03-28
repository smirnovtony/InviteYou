//
//  IYLaunchScreen.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 12.03.21.
//

import UIKit

class IYLaunchScreen: UIViewController {

    @IBOutlet weak var appLable: UILabel! {
        didSet {
            self.appLable.layer.cornerRadius = 5

//            label.textColor = .white// цвет
//            label.backgroundColor = UIColor(named: "systemColor")
//            label.font = fontFamilyBig // шрифт (размер)
//            label.textAlignment = .center // выравнивание текста
//
//            label.layer.masksToBounds = true // без этого не работает радиус, но удаляются тени...
//            label.layer.
//
//            label.layer.shadowOffset = CGSize(width: 0, height: 5) // с "-" вверх
//            label.layer.shadowRadius = 5 // радиус
//            label.layer.shadowOpacity = 0.5
//            label.layer.shadowColor = UIColor.black.cgColor // цвет
        }
    }
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
