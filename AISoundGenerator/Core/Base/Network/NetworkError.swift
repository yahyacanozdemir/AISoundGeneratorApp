//
//  NetworkError.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

enum NetworkError: Error {
  case invalidUrl
  case requestFailed(Error)
  case invalidData
  case network
  case timeout
  case parse(Error)
  case unknown

  // MARK: Internal

  var message: String {
    switch self {
    case .requestFailed(let error):
      return error.localizedDescription
    case .parse(let error):
      return error.localizedDescription
    default:
      return "Bir sorun oluştu. Biraz sonra tekrar deneyiniz."
    }
  }
}
