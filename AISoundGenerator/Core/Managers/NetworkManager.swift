//
//  NetworkManager.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Alamofire
import UIKit

protocol NetworkDelegate {
  func networkDataReceived(_ data: Any?)
  func networkErrorOccured(_ error: NetworkError, responseType: Any)
}

extension NetworkDelegate {
  func networkErrorOccured(_: NetworkError, responseType _: Any) { }
}

class NetworkManager {
  
  static let shared = NetworkManager()
  
  func sendRequest<T: Codable>(request: BaseRequest, responseType: T, completion: @escaping (Result<T, NetworkError>) -> Void) {
    guard let path = request.endpoint.url else { return }
    
    var encoding: ParameterEncoding
    switch request.parameterType {
    case .url:
      encoding = URLEncoding.queryString
    case .body:
      encoding = JSONEncoding.prettyPrinted
    default:
      encoding = JSONEncoding.default
    }
    
    AF.request(path,
               method: request.method,
               parameters: request.parameters,
               encoding: encoding,
               headers: ["Content-Type": request.contentType.rawValue])
    .validate(statusCode: 200..<300)
    .responseData { response in
      switch response.result {
      case .success(let data):
        do {
          let decodedData = try JSONDecoder().decode(T.self, from: data)
          completion(.success(decodedData))
        } catch {
          completion(.failure(.parse(error)))
        }
      case .failure(let error) :
        completion(.failure(.requestFailed(error)))
      }
    }
  }
}
