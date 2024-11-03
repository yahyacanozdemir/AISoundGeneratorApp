//
//  BaseCoordinator.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

public enum NavigationType {
  case present, push
}

// MARK: - Coordinator

public protocol Coordinator: AnyObject {
  func start(navigationType: NavigationType)
}

class BaseCoordinator: NSObject, Coordinator {
  
  // MARK: Lifecycle
  
  init(navigationController: BaseNavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: Internal
  
  var navigationController: BaseNavigationController
  
  func start(navigationType _: NavigationType = .push) { }
  
  func navigateTo(_ viewController: UIViewController, animated: Bool = true, navigationType: NavigationType = .push) {
    switch navigationType {
    case .present:
      navigationController.present(viewController, animated: animated)
    case .push:
      navigationController.pushViewController(viewController, animated: animated)
    }
  }
  
  func pop() {
    navigationController.popViewController(animated: true)
  }
}
