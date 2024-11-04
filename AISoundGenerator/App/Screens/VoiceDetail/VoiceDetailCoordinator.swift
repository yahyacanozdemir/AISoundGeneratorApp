//
//  VoiceDetailCoordinator.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Foundation

class VoiceDetailCoordinator: BaseCoordinator {
  
  func start(navigationType: NavigationType = .push, voiceUrl: String) {
    let vc = VoiceDetailVC(
      //https://firebasestorage.googleapis.com/v0/b/ai-music-virals.appspot.com/o/GeneratedAiMusics%2Fasdas%2Fe9yg2vbav9rj20cjpbn8cqp2tm?alt=media&token=5495a763-8db4-4eaa-a952-167eaeab276a
      contentView: VoiceDetailContentView(voiceUrl: voiceUrl))
    vc.coordinator = self
    navigateTo(vc, navigationType: navigationType)
  }
}
      
