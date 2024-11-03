//
//  VoiceDetailCoordinator.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Foundation

class VoiceDetailCoordinator: BaseCoordinator {
  
  override func start(navigationType: NavigationType = .push) {
    let vc = VoiceDetailVC(
      contentView: VoiceDetailContentView())
    vc.coordinator = self
    navigateTo(vc, navigationType: navigationType)
  }
}
