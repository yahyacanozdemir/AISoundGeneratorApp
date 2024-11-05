//
//  UIApplicationExt.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 5.11.2024.
//

import UIKit

extension UIApplication {
  var activeKeyWindow: UIWindow? {
    connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .compactMap { $0.windows.first { $0.isKeyWindow } }
      .first
  }
}
