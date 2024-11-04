//
//  NavbarManager.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

enum NavbarManager {

  static func placeNavbar(baseVC: UIViewController) -> BaseView? {
    switch baseVC {
    case baseVC as? HomeVC: return DefaultNavbar(title: "AI Voice", type: .onlyTitle)
    case baseVC as? VoiceGeneratingVC: return DefaultNavbar()
    case baseVC as? VoiceDetailVC: return VoiceDetailNavbar()
    default: return nil
    }
  }
}
