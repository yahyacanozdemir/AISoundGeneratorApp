//
//  BaseView.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit
import SnapKit

class BaseView: UIView, BindableLayout {
  
  init() {
    super.init(frame: .zero)
    accessibilityIdentifier = String(describing: type(of: self))
    setupUI()
    bind()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var networkManager = NetworkManager()
  var networkDelegate: NetworkDelegate?
  
  func bind() {}
  
  func viewDidLoad() {}

  func viewDidAppear() { }

  func viewDidDisappear() { }

  func viewWillAppear() {}

  func viewWillDisappear() { }

  func viewDidKill() {
    subviews.forEach { subview in
      if let view = subview as? BaseView {
        view.viewDidKill()
      }
    }
  }
  
  // MARK: - Layoutable

  final func setupUI() {
    setupSubviews()
    setupConstraints()
  }

  func setupSubviews() { }

  func setupConstraints() { }  
  
  func updateUI() { }
}

extension BaseView: NetworkListener {

  func sendRequest<T: Codable>(_ request: BaseRequest, responseType: T) {
    networkManager.sendRequest(request: request, responseType: responseType) { [weak self] (result: Result<T, NetworkError>) in
      switch result {
      case .success(let response):
        self?.networkDelegate?.networkDataReceived(response)
      case .failure(let error):
        self?.networkDelegate?.networkErrorOccured(error, responseType: responseType)
      }
    }
  }
}
