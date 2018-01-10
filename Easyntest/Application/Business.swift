//
//  Business.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import Foundation

struct Business {
  /// One should not invest more than 1B
  static var maxInvestmentAmount: Double {
    return 1000000000
  }

  /// Maturity Date must not be in the past
  static var minMaturityDate: Date {
    let components = Calendar.current.dateComponents([.day, .month, .year], from: Date())
    let date = Calendar.current.date(from: components)
    return date ?? Date()
  }

  /// Rate should be more then zero
  static var minRateValue: Int {
    return 0
  }
}
