//
//  NumberFormatter+Currency.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import Foundation

extension NumberFormatter {
  static var currencyFormatter: NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    return numberFormatter
  }
}
