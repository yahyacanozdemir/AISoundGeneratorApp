//
//  VoiceGeneratingCoordinator.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

class VoiceGeneratingCoordinator: BaseCoordinator {
  func start(navigationType: NavigationType = .push, userData: VoiceGenerateParameters) {
    let vc = VoiceGeneratingVC(
      contentView: VoiceGeneratingContentView(userData))
    vc.coordinator = self
    navigateTo(vc, navigationType: navigationType)
  }
}

extension VoiceGeneratingCoordinator {
  func navigateToVoiceDetailPage(voiceUrl: String, voicePrompt: String) {
    let voiceDetailCoordinator = VoiceDetailCoordinator(navigationController: navigationController)
    voiceDetailCoordinator.start(voiceUrl: voiceUrl, voicePrompt: voicePrompt)
  }
}
