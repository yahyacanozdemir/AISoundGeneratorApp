//
//  VoicesEntity.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

struct VoicesEntity: Codable {
  var objects: [VoiceItem?]?
    
  func getCategories() -> [String] {
    let allCategories = ["Tümü"]
    let voiceCategories = Set(objects?.compactMap { $0?.category } ?? [])

    return Array(allCategories + voiceCategories)
  }
 
  func getObjectsByCategory() -> [String: [VoiceItem?]?] {
    var categorizedObjects: [String: [VoiceItem?]?] = ["Tümü": self.objects]
    
    objects?.forEach({ item in
      if let category = item?.category {
        categorizedObjects[category, default: []]?.append(item)
      }
    })
    
    return categorizedObjects
  }
}

struct VoiceItem: Codable {
  var imageUrl: String?
  var category: String?
  var order: Int?
  var name: String?
}
