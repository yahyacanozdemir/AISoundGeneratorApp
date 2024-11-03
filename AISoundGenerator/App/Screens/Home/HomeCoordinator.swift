//
//  HomeCoordinator.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Foundation

class HomeCoordinator: Coordinator {
  
  private var navigationController: BaseNavigationController
  
  required init(navigationController: BaseNavigationController) {
    self.navigationController = navigationController
  }
  
  func start(navigationType _: NavigationType) { }
  
  func start() {
    let vc = HomeVC(
      contentView: HomeContentView())
    vc.coordinator = self
    navigationController.setViewControllers([vc], animated: false)
  }
}

extension HomeCoordinator {
  func navigateToVoiceGeneratingPage(userData: UserVoiceSelection) {
    let voiceGeneratingCoordinator = VoiceGeneratingCoordinator(navigationController: navigationController)
    voiceGeneratingCoordinator.start(userData: userData)
  }
}

import Foundation
