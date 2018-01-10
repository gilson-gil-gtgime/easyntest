//
//  ServiceAPI.swift
//  Easyntest
//
//  Created by Gilson Gil on 05/01/18.
//

import Foundation

struct ServiceAPI {
  enum HttpMethod: String {
    case get = "GET"
  }

  static func dataTask(request: NSMutableURLRequest,
                       session: URLSession = URLSession.shared,
                       completion: @escaping CompletionHandlerType<Data?>) -> URLSessionTask {
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
      guard error == nil else {
        completion { throw error! }
        return
      }
      guard let response = response else {
        completion { throw NetworkError.unknown }
        return
      }
      if let response = response as? HTTPURLResponse, response.statusCode == StatusCode.success.rawValue {
        completion { data }
      } else {
        completion { throw NetworkError.unknown }
      }
    }
    task.resume()
    return task
  }
}
