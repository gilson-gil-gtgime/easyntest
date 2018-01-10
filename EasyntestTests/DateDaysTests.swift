//
//  DateDaysTests.swift
//  EasyntestTests
//
//  Created by Gilson Gil on 09/01/18.
//

import XCTest
@testable import Easyntest

class DateDaysTests: XCTestCase {
  func testDays() {
    let components1 = DateComponents(year: 2017, month: 11, day: 20, hour: 14, minute: 33, second: 12)
    let components2 = DateComponents(year: 2018, month: 0, day: 3, hour: 8, minute: 0, second: 44)
    let components3 = DateComponents(year: 2018, month: 0, day: 3, hour: 20, minute: 0, second: 0)
    let components4 = DateComponents(year: 2017, month: 11, day: 18, hour: 12, minute: 40, second: 4)
    guard let date1 = Calendar.current.date(from: components1),
      let date2 = Calendar.current.date(from: components2),
      let date3 = Calendar.current.date(from: components3),
      let date4 = Calendar.current.date(from: components4) else {
      fatalError("invalid mock data")
    }

    let days1 = date1.days(from: date2)
    let days1b = date2.days(from: date1)

    assert(days1 == 13)
    assert(days1b == 13)

    let days2 = date1.days(from: date3)
    let days2b = date3.days(from: date1)

    assert(days2 == 13)
    assert(days2b == 13)

    let days3 = date1.days(from: date4)
    let days3b = date4.days(from: date1)

    assert(days3 == 2)
    assert(days3b == 2)

    let days4 = date2.days(from: date3)
    let days4b = date3.days(from: date2)

    assert(days4 == 0)
    assert(days4b == 0)

    let days5 = date2.days(from: date4)
    let days5b = date4.days(from: date2)

    assert(days5 == 15)
    assert(days5b == 15)

    let days6 = date3.days(from: date4)
    let days6b = date4.days(from: date3)

    assert(days6 == 15)
    assert(days6b == 15)
  }
}
