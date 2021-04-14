//
//  String+Ex.swift
//  InviteYouApp
//
//  Created by Антон Смирнов on 14.04.21.
//

import Foundation

extension String {
  func toDate(withFormat format: String = "dd MMM yyyy") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}
