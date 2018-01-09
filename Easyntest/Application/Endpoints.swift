//
//  Endpoints.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

struct Endpoints {
  static var baseURLString: String {
    return "https://api-simulator-calc.easynvest.com.br/"
  }

  static var baseURL: URL {
    guard let url = URL(string: baseURLString) else {
      fatalError()
    }
    return url
  }

  static var simulate: String {
    return "calculator/simulate"
  }
}
