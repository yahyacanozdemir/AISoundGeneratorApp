//
//  HomeRepository.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 13.11.2024.
//

protocol VoicesRepositoryProtocol {
  func getVoices(completion: @escaping (VoicesResponseType) -> ())
  func getCategories(data: VoicesEntity?) -> [String]
  func getObjectsByCategory(data: VoicesEntity?) -> [String: [VoiceItem?]?]
}

class VoicesRepository: VoicesRepositoryProtocol {

  private let service: VoicesServiceProtocol
  
  init(service: VoicesServiceProtocol = VoicesService()) {
    self.service = service
  }
  
  func getVoices(completion: @escaping (VoicesResponseType) -> ()) {
    service.fetchVoices(completion: completion)
  }
  
  //TODO: Mapper yapılabilir
  
  func getCategories(data: VoicesEntity?) -> [String] {
    let allCategories = ["Tümü"]
    let voiceCategories = Set(data?.objects?.compactMap { $0?.category } ?? [])
    
    return Array(allCategories + voiceCategories)
  }
  
  func getObjectsByCategory(data: VoicesEntity?) -> [String : [VoiceItem?]?] {
    var categorizedObjects: [String: [VoiceItem?]?] = ["Tümü": data?.objects]
    
    data?.objects?.forEach({ item in
      if let category = item?.category {
        categorizedObjects[category, default: []]?.append(item)
      }
    })
    
    return categorizedObjects
  }
  
}
