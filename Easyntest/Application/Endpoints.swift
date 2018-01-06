//
//  Endpoints.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

struct Endpoints {
  static var baseURLString: String {
    return "https://easynvestsimulatorcalcapi.azurewebsites.net/"
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
