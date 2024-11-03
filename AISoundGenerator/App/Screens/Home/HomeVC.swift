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

extension HomeVC: HomeContentViewDelegate {
  func generateButtonTapped(userData: UserVoiceSelection) {
    coordinator?.navigateToVoiceGeneratingPage(userData: userData)
  }
}
