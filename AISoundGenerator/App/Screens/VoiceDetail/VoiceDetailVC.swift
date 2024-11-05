//
//  VoiceDetailVC.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

class VoiceDetailVC: BaseVC<VoiceDetailContentView> {
  var coordinator: VoiceDetailCoordinator?
  
  override func viewDidAppear(_ animated: Bool) {
    FullScreenIndicator.shared.showLoadingView(true)
  }
  
  override func viewDidDisappear(_: Bool) {
    FullScreenIndicator.shared.showLoadingView(false)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    contentView?.deinitVoicePlayer()
  }
  
  override func bind() {
    contentView?.delegate = self
    
    if let navBar = selectedNavBar as? VoiceDetailNavbar {
      navBar.onTapBack = { [weak self] in
        self?.coordinator?.navigationController.popToRootViewController(animated: true)
      }
      
      navBar.onTapShare = { [weak self] in
        self?.contentView?.downloadAndShareVoice()
      }
      
      navBar.onTapCopyText = { [weak self] in
        let pasteboard = UIPasteboard.general
        pasteboard.string = self?.contentView?.voicePromptText
        
        ModalManager.shared.showSystemAlert(title: "İşlem Başarılı",
                                            message: "Prompt Kopyalandı")
      }
    }
  }
}

extension VoiceDetailVC: VoiceDetailDelegate {
  func showPopup(title: String, message: String) {
    ModalManager.shared.showSystemAlert(title: title,
                                        message: message,
                                        action: UIAlertAction(title: "Geri Dön",
                                                              style: .default,
                                                              handler: { action in
                                                              self.coordinator?.navigationController.popToRootViewController(animated: true)
                                                              }
                                                             ))
  }
  
  func showShareSheet(_ fileUrl: URL) {
    ModalManager.shared.showSaveOrShareSheet(fileUrl: fileUrl)
  }
}
