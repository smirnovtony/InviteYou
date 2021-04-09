//
//  IYDefault.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 31.03.21.
//

import Foundation

class IYDefault {

    static let sh = IYDefault() // обязательно

    private init() {} // обязательно, чтобы нельзя было создать еще один синглтон

    private struct Keys { // хранение всех ключей
        static let invites = "IYInvites"
    }
}
