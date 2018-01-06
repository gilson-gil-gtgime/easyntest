//
//  Simulation.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

struct Simulation: Codable {
  let investmentParameter: InvestmentParameter
  let grossAmount: Double
  let taxesAmount: Double
  let netAmount: Double
  let grossAmountProfit: Double
  let netAmountProfit: Double
  let annualGrossRateProfit: Double
  let monthlyGrossRateProfit: Double
  let dailyGrossRateProfit: Double
  let taxesRate: Double
  let rateProfit: Double
  let annualNetRateProfit: Double
}
