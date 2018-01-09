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

  var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
  }

  func request(completion: @escaping CompletionHandlerType<Simulation>) -> URLSessionTask {
    return run(completion: { (callback: () throws -> Simulation) in
      do {
        let simulation = try callback()
        completion { simulation }
      } catch {
        completion { throw error }
      }
    })
  }
}
