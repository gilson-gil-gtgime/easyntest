//
//  NumberFormatter+Percentage.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import Foundation

final class PercentageFormatter: NumberFormatter {
  static var percentageFormatter: PercentageFormatter {
    let numberFormatter = PercentageFormatter()
    numberFormatter.decimalSeparator = ","
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.minimumIntegerDigits = 1
    return numberFormatter
  }

  override func string(from number: NSNumber) -> String? {
    guard let string = super.string(from: number) else {
      return nil
    }
    return string + "%"
  }
}
