//
//  ModalManager.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 5.11.2024.
//

import Foundation
import UIKit

class ModalManager {
  static let shared = ModalManager()
  
  var topViewController: UIViewController? {
    var topController = UIApplication.shared.activeKeyWindow?.rootViewController

    while let presentedViewController = topController?.presentedViewController {
      topController = presentedViewController
    }

    return topController
  }

  func dismiss() {
    topViewController?.dismiss(animated: false)
  }
  
  func showSystemAlert(title: String, message: String, action: UIAlertAction? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    if let action {
      alert.addAction(action)
    }
    topViewController?.present(alert, animated: true, completion: nil)

    if action == nil {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        alert.dismiss(animated: true)
      })
    }
  }

  func showSaveOrShareSheet(fileUrl: URL) {
    let activityVC = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
    topViewController?.present(activityVC, animated: true, completion: nil)
  }
}
