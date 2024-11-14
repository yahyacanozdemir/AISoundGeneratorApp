//
//  BaseNavigationController.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

class BaseNavigationController: UINavigationController {

  // MARK: Internal

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    isNavigationBarHidden = true
  }
}
