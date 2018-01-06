//
//  SimulationParameters.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

struct SimulationParameters: Codable {
  let investedAmount: Double
  let index: String = "CDI"
  let rate: Int
  let isTaxFree: Bool = false
  let maturityDate: String
}
