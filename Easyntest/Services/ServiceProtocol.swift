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
  var decoder: JSONDecoder { get }

  @discardableResult
  func run<T: Decodable>(completion: @escaping CompletionHandlerType<T>) -> URLSessionTask
}

extension ServiceProtocol {
  @discardableResult
  func run<T: Decodable>(completion: @escaping CompletionHandlerType<T>) -> URLSessionTask {
    let queries = parameters?.flatMap {
      URLQueryItem(name: $0.key, value: "\($0.value)")
    }
    let urlRaw = Endpoints.baseURL.appendingPathComponent(Endpoints.simulate)
    var urlComponents = URLComponents(url: urlRaw, resolvingAgainstBaseURL: true)
    urlComponents?.queryItems = queries

    let url = urlComponents?.url ?? Endpoints.baseURL
    let request = NSMutableURLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = method.rawValue

    return ServiceAPI.dataTask(request: request) { callback in
      do {
        guard let data = try callback() else {
          completion { throw ServiceError.typeMismatch }
          return
        }
        let object = try self.decoder.decode(T.self, from: data)
        completion { object }
      } catch {
        completion { throw error }
      }
    }
  }
}
