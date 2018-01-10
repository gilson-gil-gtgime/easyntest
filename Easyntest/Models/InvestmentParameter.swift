//
//  InvestmentParameter.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

struct InvestmentParameter: Codable {
  let investedAmount: Double
  let yearlyInterestRate: Double
  let maturityTotalDays: Int
  let maturityBusinessDays: Int
  let maturityDate: Date
  let rate: Double
  let isTaxFree: Bool
}
