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

  func run(completion: @escaping (() throws -> Simulation) -> Void) -> URLSessionTask {
    return self.run(returnType: Simulation.self, completion: { callback in
      do {
        let simulation = try callback()
        completion { simulation }
      } catch {
        let json: [String: Any] = [
          "investmentParameter": [
            "investedAmount": 32323.0,                      // O valor a ser investido
            "yearlyInterestRate": 9.5512,                   // Rentabilidade anual
            "maturityTotalDays": 1981,                      // Dias corridos
            "maturityBusinessDays": 1409,                   // Dias úteis
            "maturityDate": "2023-03-03T00:00:00",          // Data de vencimento
            "rate": 123.0,                                  // Percentual do papel
            "isTaxFree": false                              // Isento de IR
          ],
          "grossAmount": 60528.20,                            // Valor bruto do investimento
          "taxesAmount": 4230.78,                             // Valor do IR
          "netAmount": 56297.42,                              // Valor líquido
          "grossAmountProfit": 28205.20,                      // Rentabilidade bruta
          "netAmountProfit": 23974.42,                        // Rentabilidade líquida
          "annualGrossRateProfit": 87.26,                     // Rentabilidade bruta anual
          "monthlyGrossRateProfit": 0.76,                     // Rentabilidade bruta mensal
          "dailyGrossRateProfit": 0.000445330025305748,       // Rentabilidade bruta diária
          "taxesRate": 15.0,                                  // Faixa do IR (%)
          "rateProfit": 9.5512,                               // Rentabilidade no período
          "annualNetRateProfit": 74.17                        // Rentabilidade líquida anual
        ]
        let data = try? JSONSerialization.data(withJSONObject: json, options: [])
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let simulation = try? decoder.decode(Simulation.self, from: data!)
        completion { simulation! }
      }
    })
  }
}
