//
//  SimulationResultViewModel.swift
//  Easyntest
//
//  Created by Gilson Gil on 07/01/18.
//

import Foundation

struct SimulationResultViewModel {
  let coordinator: SimulationResultCoordinator
  let simulation: Simulation
  let configurators: [[CellConfiguratorType]]
  let currencyFormatter = NumberFormatter.currencyFormatter
  let percentageFormatter = PercentageFormatter.percentageFormatter
  let dateFormatter = DateFormatter.formatter

  init(coordinator: SimulationResultCoordinator) {
    self.coordinator = coordinator
    self.simulation = coordinator.simulation
    let gross = currencyFormatter.string(from: NSNumber(value: simulation.grossAmount)) ?? ""
    let profit = currencyFormatter.string(from: NSNumber(value: simulation.grossAmountProfit)) ?? ""
    let summaryViewModel = SimulationSummaryViewModel(gross: gross, profit: profit)
    let detailViewModels1 = SimulationResultViewModel.details1(simulation: simulation,
                                                               currFormatter: currencyFormatter,
                                                               percFormatter: percentageFormatter,
                                                               dateFormatter: dateFormatter)
    let detailViewModels2 = SimulationResultViewModel.details2(simulation: simulation,
                                                               currFormatter: currencyFormatter,
                                                               percFormatter: percentageFormatter,
                                                               dateFormatter: dateFormatter)

    self.configurators = [
      [
        CellConfigurator<SimulationSummaryCell>(viewModel: summaryViewModel)
      ],
      detailViewModels1.flatMap {
        CellConfigurator<SimulationDetailCell>(viewModel: $0)
      },
      detailViewModels2.flatMap {
        CellConfigurator<SimulationDetailCell>(viewModel: $0)
      },
      [
        CellConfigurator<SimulationButtonCell>(viewModel: nil)
      ]
    ]
  }

  static func details1(simulation: Simulation,
                       currFormatter: NumberFormatter,
                       percFormatter: PercentageFormatter,
                       dateFormatter: DateFormatter) -> [SimulationDetailViewModel] {
    let amount = currFormatter.string(from: NSNumber(value: simulation.taxesAmount)) ?? ""
    let rate = percFormatter.string(from: NSNumber(value: simulation.taxesRate)) ?? ""
    return [
      SimulationDetailViewModel(title: String.SimulationResult.investedLabel,
                                value: currFormatter.string(from: NSNumber(value: simulation.investedAmount))),
      SimulationDetailViewModel(title: String.SimulationResult.grossLabel,
                                value: currFormatter.string(from: NSNumber(value: simulation.grossAmount))),
      SimulationDetailViewModel(title: String.SimulationResult.profitLabel,
                                value: currFormatter.string(from: NSNumber(value: simulation.grossAmountProfit))),
      SimulationDetailViewModel(title: String.SimulationResult.taxLabel,
                                value: "\(amount)(\(rate))"),
      SimulationDetailViewModel(title: String.SimulationResult.netLabel,
                                value: currFormatter.string(from: NSNumber(value: simulation.netAmount)))
    ]
  }

  static func details2(simulation: Simulation,
                       currFormatter: NumberFormatter,
                       percFormatter: PercentageFormatter,
                       dateFormatter: DateFormatter) -> [SimulationDetailViewModel] {
    return [
      SimulationDetailViewModel(title: String.SimulationResult.maturityLabel,
                                value: dateFormatter.string(from: simulation.investmentParameter.maturityDate)),
      SimulationDetailViewModel(title: String.SimulationResult.daysLabel,
                                value: String(simulation.investmentParameter.maturityDate.daysFromNow)),
      SimulationDetailViewModel(title: String.SimulationResult.monthlyRateLabel,
                                value: percFormatter.string(from: NSNumber(value: simulation.monthlyGrossRateProfit))),
      SimulationDetailViewModel(title: String.SimulationResult.rateLabel,
                                value: percFormatter.string(from: NSNumber(value: simulation.rate))),
      SimulationDetailViewModel(title: String.SimulationResult.annualRateLabel,
                                value: percFormatter.string(from: NSNumber(value: simulation.annualGrossRateProfit))),
      SimulationDetailViewModel(title: String.SimulationResult.periodRateLabel,
                                value: percFormatter.string(from: NSNumber(value: simulation.rateProfit)))
    ]
  }

  func footerHeight(for section: Int) -> Float {
    let configurators = self.configurators[section]
    guard let viewModel = configurators.first?.currentViewModel() else {
      return 0
    }
    if viewModel is SimulationDetailViewModel {
      return 50
    } else {
      return 0
    }
  }

  func didTapReset() {
    coordinator.delegate?.didTapReset(at: coordinator)
  }
}
