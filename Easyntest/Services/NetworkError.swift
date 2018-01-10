//
//  NetworkError.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

enum NetworkError: Error {
  case timeout
  case noConnection
  case server
  case unknown

  init?(statusCode: Int?, error: Error?) {
    if let statusCode = statusCode {
      switch statusCode {
      case StatusCode.server.rawValue:
        self = .server
        return
      default:
        break
      }
    }
    if let error = error {
      switch error._code {
      case NSURLErrorTimedOut:
        self = .timeout
        return
      case NSURLErrorNotConnectedToInternet:
        self = .noConnection
        return
      default:
        break
      }
    }
    return nil
  }

  var localizedDescription: String {
    switch self {
    case .timeout, .server, .unknown:
      return "Não foi possível conectar com o servidor, por favor, tente novamente mais tarde."
    case .noConnection:
      return "Sem conexão com a internet, verifique seu sinal"
    }
  }
}
