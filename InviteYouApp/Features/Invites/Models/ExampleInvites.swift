//
//  ExampleInvites.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 7.04.21.
//

import Foundation

struct ExampleInvites {//: Codable { // подчинили протоколу кодирования и декодирования
//    var id = UUID() // уникальный идентификатор. UUID() присваивает уникальное 16значное значение
    var logo: String // можно из галереи брать для внутренних мероприятий
//    var qr: String? //????????
    var nameOrganizer: String
//    var infoAboutOrganizer: String
    var nameOfEvent: String
//    var typeOfIvent: String
//    var person: String?
    var address: String
    var date: String
//    var time: String?
//    var infoAboutEvent: String?
    var closedOrOpen: Bool
//    var subscribe: Bool
}
