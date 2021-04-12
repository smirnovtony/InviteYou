//
//  IYIvent.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 7.04.21.
//

class IYIvent: Decodable { // для передачи. есть еще две модели для приема и приема-передачи
    let id: Int
    let logo: String?
    let nameOrganizer: String
    let infoAboutOrganizer: String?
    let nameOfEvent: String
    let typeOfIvent: String //picker
    let person: String? //picker
    let address: String
    let date: String? //picker
    let time: String? //picker
    let infoAboutEvent: String?
    let closedOrOpen: Bool
    let subscribe: Bool
}
