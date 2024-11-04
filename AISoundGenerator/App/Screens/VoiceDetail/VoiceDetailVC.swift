//
//  VoiceDetailVC.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

class VoiceDetailVC: BaseVC<VoiceDetailContentView> {
  var coordinator: VoiceDetailCoordinator?
  
  override func bind() {
    contentView?.delegate = self
    
    if let navBar = selectedNavBar as? VoiceDetailNavbar {
      navBar.onTapBack = {
        self.coordinator?.pop()
      }
    }
  }
}

extension VoiceDetailVC: VoiceDetailDelegate {
  func showErrorPopup(title: String?, message: String?) {
    showErrorPopup(on: self, title: title, message: message)
  }
}

extension VoiceDetailVC {
  func showErrorPopup(on viewController: UIViewController, title: String? = "Hata", message: String? = "Bir problem oluştu") {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
    alert.addAction(okAction)
    
    viewController.present(alert, animated: true, completion: nil)
  }
}
