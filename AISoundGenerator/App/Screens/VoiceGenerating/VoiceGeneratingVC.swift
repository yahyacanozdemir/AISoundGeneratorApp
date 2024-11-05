//
//  VoiceGeneratingVC.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Foundation

class VoiceGeneratingVC: BaseVC<VoiceGeneratingContentView>{
  var coordinator: VoiceGeneratingCoordinator?
  
  override func bind() {
    contentView?.delegate = self
    
    if let navBar = selectedNavBar as? DefaultNavbar {
      navBar.onTapBack = { [weak self] in
        self?.coordinator?.pop()
      }
    }
  }
}

//MARK: Navigation

extension VoiceGeneratingVC: VoiceGeneratingContentViewDelegate {
  func voiceGenerated(resultUrl: String, voicePrompt: String) {
    coordinator?.navigateToVoiceDetailPage(voiceUrl: resultUrl, voicePrompt: voicePrompt)
  }
}
