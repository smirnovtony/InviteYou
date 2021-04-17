//
//  IYDefault.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 31.03.21.
//

import Foundation
import FirebaseDatabase

class IYDefault {

    static let sh = IYDefault() // обязательно

    private let databaseReference: DatabaseReference

    private init() {
        databaseReference = Database.database().reference()
    }

    private struct Keys { // хранение всех ключей
        static let userStatus = "userLoggedBool"
    }

    lazy var userLogged: Bool = self.loadTestValue()
    func saveTestValue() {
        UserDefaults.standard.setValue(userLogged, forKey: "userLoggedBool")
    }

    func loadTestValue() -> Bool {
        let value = UserDefaults.standard.value(forKey: "userLoggedBool") as? Bool
        return value ?? true
    }

}
