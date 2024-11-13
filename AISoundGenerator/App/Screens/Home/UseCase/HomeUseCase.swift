//
//  HomeUseCase.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 13.11.2024.
//

import Foundation

protocol HomeUseCaseProtocol {
  func execute(completion: @escaping (VoicesResponseType) -> ())
  func getCategories(data: VoicesEntity?) -> [String]?
  func getObjectsByCategory(data: VoicesEntity?) -> [String : [VoiceItem?]?]
}

class HomeUseCase: HomeUseCaseProtocol {

  private let repository: VoicesRepositoryProtocol
  
  init(voicesRepository: VoicesRepositoryProtocol) {
    self.repository = voicesRepository
  }
  
  func execute(completion: @escaping (VoicesResponseType) -> ()) {
    repository.getVoices(completion: completion)
  }
  
  func getCategories(data: VoicesEntity?) -> [String]? {
    repository.getCategories(data: data)
  }
  
  func getObjectsByCategory(data: VoicesEntity?) -> [String : [VoiceItem?]?] {
    repository.getObjectsByCategory(data: data)
  }
}
