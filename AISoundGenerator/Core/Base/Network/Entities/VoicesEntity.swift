//
//  VoicesEntity.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

struct VoicesEntity: Codable {
  var objects: [VoiceItem?]?
}

struct VoiceItem: Codable {
  var imageUrl: String?
  var category: String?
  var order: Int?
  var name: String?
}
