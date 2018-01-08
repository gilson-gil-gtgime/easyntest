//
//  Date+days.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import Foundation

extension Date {
  func days(from: Date) -> Int {
    let adjustedFrom = Calendar.current.startOfDay(for: from)
    let adjustedSelf = Calendar.current.startOfDay(for: self)
    let components = Calendar.current.dateComponents([.day], from: adjustedFrom, to: adjustedSelf)
    return abs(components.day ?? 0)
  }

  var daysFromNow: Int {
    return days(from: Date())
  }
}
