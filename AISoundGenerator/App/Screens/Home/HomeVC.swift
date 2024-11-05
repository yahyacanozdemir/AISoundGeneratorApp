//
//  HomeVC.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

class HomeVC: BaseVC<HomeContentView> {
  var coordinator: HomeCoordinator?
  
  override func bind() {
    contentView?.delegate = self
  }
}

//MARK: Navigation

extension HomeVC: HomeContentViewDelegate {
  func generateButtonTapped(userData: VoiceGenerateParameters) {
    coordinator?.navigateToVoiceGeneratingPage(userData: userData)
  }
}
