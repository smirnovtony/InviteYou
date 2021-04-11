//
//  IYDefault.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 31.03.21.
//

import Foundation

class IYDefault {

    static let sh = IYDefault() // обязательно

//    var userLogged: Bool = false

    private init() {} // обязательно, чтобы нельзя было создать еще один синглтон

    private struct Keys { // хранение всех ключей
        static let userStatus = "userLoggedBool"
    }

    lazy var userLogged: Bool = self.loadTestValue()

    func saveTestValue() {
        UserDefaults.standard.setValue(userLogged, forKey: "userLoggedBool") // сохранение значения
    }
    func loadTestValue() -> Bool {
        let value = UserDefaults.standard.value(forKey: "userLoggedBool") as? Bool // возвращение значения
        return value ?? true
    }
}
