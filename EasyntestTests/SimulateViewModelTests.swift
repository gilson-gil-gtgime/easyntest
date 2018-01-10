//
//  SimulateViewModelTests.swift
//  EasyntestTests
//
//  Created by Gilson Gil on 09/01/18.
//

import XCTest
@testable import Easyntest

class SimulateViewModelTests: XCTestCase {
  let coordinator = SimulateCoordinator(navigationController: UINavigationController())
  var amountViewModel: SimulateViewModel?

  func testIsValid() {
    let test1 = SimulateViewModel(coordinator: coordinator)

    assert(!test1.isValid)
    assert(test1.amount == nil || test1.maturity == nil || test1.rate == nil)

    let test2 = SimulateViewModel(coordinator: coordinator, amount: 100)

    assert(!test2.isValid)
    assert(test2.amount == nil || test2.maturity == nil || test2.rate == nil)

    let test3 = SimulateViewModel(coordinator: coordinator, maturity: Date())

    assert(!test3.isValid)
    assert(test3.amount == nil || test3.maturity == nil || test3.rate == nil)

    let test4 = SimulateViewModel(coordinator: coordinator, rate: 100)

    assert(!test4.isValid)
    assert(test4.amount == nil || test4.maturity == nil || test4.rate == nil)

    let test5 = SimulateViewModel(coordinator: coordinator, amount: 100, maturity: Date())

    assert(!test5.isValid)
    assert(test5.amount == nil || test5.maturity == nil || test5.rate == nil)

    let test6 = SimulateViewModel(coordinator: coordinator, amount: 100, rate: 100)

    assert(!test6.isValid)
    assert(test6.amount == nil || test6.maturity == nil || test6.rate == nil)

    let test7 = SimulateViewModel(coordinator: coordinator, maturity: Date(), rate: 100)

    assert(!test7.isValid)
    assert(test7.amount == nil || test7.maturity == nil || test7.rate == nil)

    let test8 = SimulateViewModel(coordinator: coordinator, amount: 100, maturity: Date(), rate: 100)

    assert(test8.isValid)
    assert(test8.amount != nil && test8.maturity != nil && test8.rate != nil)
  }

  func testInsertAmountDigit() {
    let viewModel = SimulateViewModel(coordinator: coordinator)

    let test1 = viewModel.insertAmountDigit("1")

    assert(test1.amount == 0.01)

    let test2 = test1.insertAmountDigit("0")

    assert(test2.amount == 0.1)

    let test3 = test2.insertAmountDigit("5")

    assert(test3.amount == 1.05)

    let test4 = test3.insertAmountDigit("8")

    assert(test4.amount == 10.58)

    let test5 = test4.insertAmountDigit("3")

    assert(test5.amount == 105.83)

    amountViewModel = test5
  }

  func testRemoveAmountDigit() {
    let viewModel = SimulateViewModel(coordinator: coordinator, amount: 105.83)

    let test1 = viewModel.removeAmountDigit()

    assert(test1.amount == 10.58)

    let test2 = test1.removeAmountDigit()

    assert(test2.amount == 1.05)

    let test3 = test2.removeAmountDigit()

    assert(test3.amount == 0.1)

    let test4 = test3.removeAmountDigit()

    assert(test4.amount == 0.01)

    let test5 = test4.removeAmountDigit()

    assert(test5.amount == nil)
  }

  func testNewMaturity() {
    let viewModel = SimulateViewModel(coordinator: coordinator)

    let date1 = Date()

    let test1 = viewModel.newMaturity(date: date1)

    assert(test1.maturity == date1)

    let date2 = Date.distantPast

    let test2 = test1.newMaturity(date: date2)

    assert(test2.maturity != date2)

    let date3 = Date.distantFuture

    let test3 = test2.newMaturity(date: date3)

    assert(test3.maturity == date3)

    let date4 = Date().addingTimeInterval(60 * 60 * 24 * 365)

    let test4 = test3.newMaturity(date: date4)

    assert(test4.maturity == date4)
  }

  // MARK: - Rate
  func testInsertRateDigit() {
    let viewModel = SimulateViewModel(coordinator: coordinator)

    let test1 = viewModel.insertRateDigit("1")

    assert(test1.rate == 1)

    let test2 = test1.insertRateDigit("0")

    assert(test2.rate == 10)

    let test3 = test2.insertRateDigit("5")

    assert(test3.rate == 105)

    let test4 = test3.insertRateDigit("8")

    assert(test4.rate == 1058)

    let test5 = test4.insertRateDigit("3")

    assert(test5.rate == 10583)

    amountViewModel = test5
  }

  func testRemoveRateDigit() {
    let viewModel = SimulateViewModel(coordinator: coordinator, rate: 10583)

    let test1 = viewModel.removeRateDigit()

    assert(test1.rate == 1058)

    let test2 = test1.removeRateDigit()

    assert(test2.rate == 105)

    let test3 = test2.removeRateDigit()

    assert(test3.rate == 10)

    let test4 = test3.removeRateDigit()

    assert(test4.rate == 1)

    let test5 = test4.removeRateDigit()

    assert(test5.rate == nil)
  }

  func testSubmitTapped() {
    let viewModel = SimulateViewModel(coordinator: coordinator)

    let test1 = viewModel
      .submitTapped(completion: { _ in })

    assert(test1.currentTask == nil)

    let test2 = viewModel
      .insertAmountDigit("1")
      .submitTapped(completion: { _ in })

    assert(test2.currentTask == nil)

    let test3 = viewModel
      .insertAmountDigit("1")
      .newMaturity(date: Date())
      .submitTapped(completion: { _ in })

    assert(test3.currentTask == nil)

    let test4 = viewModel
      .insertAmountDigit("1")
      .insertRateDigit("2")
      .submitTapped(completion: { _ in })

    assert(test4.currentTask == nil)

    let test5 = viewModel
      .newMaturity(date: Date())
      .submitTapped(completion: { _ in })

    assert(test5.currentTask == nil)

    let test6 = viewModel
      .newMaturity(date: Date())
      .insertRateDigit("2")
      .submitTapped(completion: { _ in })

    assert(test6.currentTask == nil)

    let test7 = viewModel
      .insertRateDigit("2")
      .submitTapped(completion: { _ in })

    assert(test7.currentTask == nil)

    let test8 = viewModel
      .insertAmountDigit("1")
      .newMaturity(date: Date())
      .insertRateDigit("2")
      .submitTapped(completion: { _ in })

    assert(test8.currentTask != nil)
  }

  func testReset() {
    let viewModel = SimulateViewModel(coordinator: coordinator)

    let test1 = viewModel.insertAmountDigit("1")

    assert(test1.amount == 0.01)

    let test2 = test1.reset()

    assert(test2.amount == nil)

    let date3 = Date()
    let test3 = viewModel.newMaturity(date: date3)

    assert(test3.maturity == date3)

    let test4 = test3.reset()

    assert(test4.maturity == nil)

    let test5 = viewModel.insertRateDigit("1")

    assert(test5.rate == 1)

    let test6 = test5.reset()

    assert(test6.rate == nil)
  }

  func testNewCurrentTask() {
    let viewModel = SimulateViewModel(coordinator: coordinator)

    let test1 = viewModel

    assert(test1.currentTask == nil)

    let task2 = URLSessionTask()
    let test2 = test1.newCurrentTask(task2)

    assert(test2.currentTask == task2)
  }

  func testCancelCurrentTask() {
    let viewModel = SimulateViewModel(coordinator: coordinator)

    let test1 = viewModel

    assert(test1.currentTask == nil)

    let viewModel2 = SimulateViewModel(coordinator: coordinator, amount: 100, maturity: Date(), rate: 100)
    let test2 = viewModel2.submitTapped(completion: { _ in })

    assert(test2.currentTask != nil)

    let test3 = test2.cancelCurrentTask()

    assert(test3.currentTask == nil)
  }
}
