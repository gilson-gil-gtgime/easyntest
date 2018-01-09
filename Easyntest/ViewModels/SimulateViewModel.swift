//
//  SimulateViewModel.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import Foundation

struct SimulateViewModel {
  let coordinator: SimulateCoordinator
  let amount: Double?
  let maturity: Date?
  let rate: Int?
  let currencyFormatter: NumberFormatter
  let dateFormatter: DateFormatter

  // MARK: - View Controller Values
  var formattedAmount: String? {
    guard let amount = amount else {
      return nil
    }
    return currencyFormatter.string(from: NSNumber(value: amount))
  }

  var formattedMaturity: String? {
    guard let maturity = maturity else {
      return nil
    }
    return dateFormatter.string(from: maturity)
  }

  var formattedRate: String? {
    guard let rate = rate else {
      return nil
    }
    return "\(rate)%"
  }

  var isValid: Bool {
    let isValid = amount != nil && maturity != nil && rate != nil
    return isValid
  }

  // MARK: - Init
  init(coordinator: SimulateCoordinator,
       amount: Double? = nil,
       maturity: Date? = nil,
       rate: Int? = nil,
       currencyFormatter: NumberFormatter = NumberFormatter.currencyFormatter,
       dateFormatter: DateFormatter = DateFormatter.formatter) {
    self.coordinator = coordinator
    self.amount = amount
    self.maturity = maturity
    self.rate = rate
    self.currencyFormatter = currencyFormatter
    self.dateFormatter = dateFormatter
  }

  // MARK: - Amount
  func insertAmountDigit(_ digit: String) -> SimulateViewModel {
    guard let digit = Int(digit) else {
      return self
    }
    let amount = self.amount ?? 0
    guard amount * 10 <= Business.maxInvestmentAmount else {
      return self
    }
    let newAmount = (amount * 100 * 10 + Double(digit)) / 100
    let viewModel = SimulateViewModel(coordinator: coordinator,
                                      amount: newAmount,
                                      maturity: maturity,
                                      rate: rate,
                                      currencyFormatter: currencyFormatter,
                                      dateFormatter: dateFormatter)
    return viewModel
  }

  func removeAmountDigit() -> SimulateViewModel {
    guard let amount = amount, amount > 0 else {
      return self
    }
    let lastDigit = (amount * 100).truncatingRemainder(dividingBy: 10)
    var newAmount: Double? = ((amount * 100 - lastDigit) / 10) / 100
    if newAmount == 0 {
      newAmount = nil
    }
    let viewModel = SimulateViewModel(coordinator: coordinator,
                                      amount: newAmount,
                                      maturity: maturity,
                                      rate: rate,
                                      currencyFormatter: currencyFormatter,
                                      dateFormatter: dateFormatter)
    return viewModel
  }

  // MARK: - Maturity
  func newMaturity(date: Date) -> SimulateViewModel {
    guard date >= Business.minMaturityDate else {
      return self
    }
    return SimulateViewModel(coordinator: coordinator,
                             amount: amount,
                             maturity: date,
                             rate: rate,
                             currencyFormatter: currencyFormatter,
                             dateFormatter: dateFormatter)
  }

  // MARK: - Rate
  func insertRateDigit(_ digit: String) -> SimulateViewModel {
    guard let digit = Int(digit) else {
      return self
    }
    let rate = self.rate ?? 0
    let newRate = rate * 10 + digit
    guard newRate > Business.minRateValue else {
      return self
    }
    let viewModel = SimulateViewModel(coordinator: coordinator,
                                      amount: amount,
                                      maturity: maturity,
                                      rate: newRate,
                                      currencyFormatter: currencyFormatter,
                                      dateFormatter: dateFormatter)
    return viewModel
  }

  func removeRateDigit() -> SimulateViewModel {
    guard let rate = rate, rate > 0 else {
      return self
    }
    var newRate: Int? = rate / 10
    if newRate! <= Business.minRateValue {
      newRate = nil
    }
    let viewModel = SimulateViewModel(coordinator: coordinator,
                                      amount: amount,
                                      maturity: maturity,
                                      rate: newRate,
                                      currencyFormatter: currencyFormatter,
                                      dateFormatter: dateFormatter)
    return viewModel
  }

  // MARK: - Submit
  func submitTapped() {
    guard let amount = amount, let maturity = maturity, let rate = rate else {
      return
    }
    let maturityString = DateFormatter.api.string(from: maturity)
    let parameters = SimulationParameters(investedAmount: amount, rate: rate, maturityDate: maturityString)
    let service = SimulateService(simulationParameters: parameters)
    let task = service.request { callback in
      do {
        let simulation = try callback()
        self.coordinator.delegate?.didSimutale(simulation: simulation)
      } catch {
        print(error)
      }
    }
    print(task)
  }

  func reset() -> SimulateViewModel {
    return SimulateViewModel(coordinator: coordinator)
  }
}
