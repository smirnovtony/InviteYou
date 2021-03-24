//
//  Date+EX.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 24.03.21.
//

import Foundation

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: self)
    }
}

extension Date {
    var timeToString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh mm"
        return formatter.string(from: self)
    }
}
