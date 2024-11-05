//
//  VoiceDetailCoordinator.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

class VoiceDetailCoordinator: BaseCoordinator {
  func start(navigationType: NavigationType = .push, voiceUrl: String, voicePrompt: String) {
    let vc = VoiceDetailVC(
      contentView: VoiceDetailContentView(voiceUrl: voiceUrl, voicePrompt: voicePrompt))
    vc.coordinator = self
    navigateTo(vc, navigationType: navigationType)
  }
}
      
