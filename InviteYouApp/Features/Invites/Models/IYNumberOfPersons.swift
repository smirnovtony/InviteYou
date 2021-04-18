//
//  IYNumberOfPersons.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 25.03.21.
//

import Foundation

enum IYNumberOfPersons: String, CaseIterable {
    case little = "1-10 persons"
    case middle = "10-20 persons"
    case big = "20-50 persons"
    case more = "More 50 persons"
    case no = "One"
    case unknow = "Unknow"
}
