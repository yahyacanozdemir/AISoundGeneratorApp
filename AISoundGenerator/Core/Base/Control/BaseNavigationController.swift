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
    setupNavigationBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    isNavigationBarHidden = true
  }

  // MARK: Private

  private func setupNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor.black
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    navigationBar.tintColor = UIColor.white
    navigationBar.standardAppearance = appearance
    navigationBar.compactAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
  }
}
