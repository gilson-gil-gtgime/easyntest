//
//  ServiceProtocol.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

enum ServiceError: Error {
  case typeMismatch

  var localizedDescription: String {
    switch self {
    case .typeMismatch:
      return "Retorno do servidor inesperado"
    }
  }
}

protocol ServiceProtocol {
  var method: ServiceAPI.HttpMethod { get }
  var path: String { get }
  var parameters: [String: Any]? { get }

  @discardableResult
  func run<T>(returnType: T.Type, completion: @escaping CompletionHandlerType<T>) -> URLSessionTask
}

extension ServiceProtocol {
  @discardableResult
  func run<T>(returnType: T.Type, completion: @escaping CompletionHandlerType<T>) -> URLSessionTask {
    var url = Endpoints.baseURL.appendingPathComponent(path)

    if let parameters = parameters {
      let parametersString = parameters.reduce("") { result, next in
        guard let escapedKey = next.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
          return result
        }
        return result + "\(escapedKey)=\(next.value)"
      }
      url.appendPathComponent(parametersString)
    }

    let request = NSMutableURLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = method.rawValue

    return ServiceAPI.dataTask(request: request) { callback in
      do {
        guard let data = try callback() as? T else {
          completion { throw ServiceError.typeMismatch }
          return
        }
        completion { data }
      } catch {
        completion { throw error }
      }
    }
  }
}
