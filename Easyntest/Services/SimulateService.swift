//
//  SimulateService.swift
//  Easyntest
//
//  Created by Gilson Gil on 06/01/18.
//

import Foundation

struct SimulateService: ServiceProtocol {
  let simulationParameters: SimulationParameters

  var method: ServiceAPI.HttpMethod { return .get }

  var path: String { return Endpoints.simulate }

  var parameters: [String: Any]? {
    let jsonEncoder = JSONEncoder()
    guard let data = try? jsonEncoder.encode(simulationParameters) else {
      return nil
    }
    guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      return nil
    }
    return json
  }
}
