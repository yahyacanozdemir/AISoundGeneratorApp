//
//  VoicesService.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 13.11.2024.
//

protocol VoicesServiceProtocol {
  func fetchVoices(completion: @escaping(VoicesResponseType) -> Void)
}

enum VoicesResponseType{
  case fetchProductDetailsuccess(voices: VoicesEntity?), fetchVoicesFail
}

class VoicesService: VoicesServiceProtocol {
  func fetchVoices(completion: @escaping (VoicesResponseType) -> Void) {
    let request = BaseRequest(
      endpoint: .voices,
      method: .post)
    
    NetworkManager.shared.sendRequest(request: request, responseType: VoicesEntity()) { result in
      switch result {
      case .success(let response):
        completion(.fetchProductDetailsuccess(voices: response))
      case .failure(_):
        completion(.fetchVoicesFail)
      }
    }
  }
}
