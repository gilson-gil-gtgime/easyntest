//
//  String+Easyntest.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import Foundation

extension String {
  struct Simulate {
    static var amountLabel: String {
      return NSLocalizedString("simulate.label.amount", comment: "")
    }

    static var amountPlaceholder: String {
      return NSLocalizedString("simulate.placeholder.amount", comment: "")
    }

    static var maturityLabel: String {
      return NSLocalizedString("simulate.label.maturity", comment: "")
    }

    static var maturityPlaceholder: String {
      return NSLocalizedString("simulate.placeholder.maturity", comment: "")
    }

    static var rateLabel: String {
      return NSLocalizedString("simulate.label.rate", comment: "")
    }

    static var ratePlaceholder: String {
      return NSLocalizedString("simulate.placeholder.rate", comment: "")
    }

    static var button: String {
      return NSLocalizedString("simulate.button", comment: "")
    }
  }
}
