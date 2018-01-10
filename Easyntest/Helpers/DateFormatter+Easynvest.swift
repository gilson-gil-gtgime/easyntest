//
//  DateFormatter+Easynvest.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import Foundation

extension DateFormatter {
  static var formatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return dateFormatter
  }

  static var api: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
  }
}
