//
//  Endpoint.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Foundation

enum Endpoint {
  case voices
  case generateVoice
  
  private var path: String {
    switch self {
    case .voices: "getVoice"
    case .generateVoice : "startMusicGenerate"
    }
  }
  
  var url: URL? {
    URL(string: AppSettings.baseAPIURL + path)
  }
}
