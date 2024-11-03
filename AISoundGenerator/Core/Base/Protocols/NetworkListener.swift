//
//  NetworkListener.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Foundation

protocol NetworkListener {
  var networkManager: NetworkManager { get set }
  func sendRequest<T: Codable>(_ request: BaseRequest, responseType: T)
}
