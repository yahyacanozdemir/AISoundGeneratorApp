//
//  FullScreenIndicator.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 5.11.2024.
//

import UIKit

// MARK: - FullScreenIndicator

final class FullScreenIndicator: UIView {

  // MARK: Internal

  static var shared = FullScreenIndicator()

  func showLoadingView(_ show: Bool, message: String? = nil) {
    DispatchQueue.main.async {
      if let existingView = UIApplication.shared.activeKeyWindow?.viewWithTag(self.loadingViewTag) {
        existingView.removeFromSuperview()
        return
      }

      if show {
        self.loadingView.updateMessage(message)
        UIApplication.shared.activeKeyWindow?.addSubview(self.loadingView)
      }
    }
  }

  // MARK: Private

  private lazy var loadingView: LoadingView = {
    let view = LoadingView(frame: UIScreen.main.bounds)
    view.tag = loadingViewTag
    return view
  }()

  private var loadingViewTag = 1200
}

final class LoadingView: UIView {

  // MARK: Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    prepareLoadingView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    prepareLoadingView()
  }

  // MARK: Private

  private lazy var outsideView: UIView = {
    let view = UIView()
    view.backgroundColor = .papcornsDark
    view.layer.cornerRadius = 16
    return view
  }()

  private lazy var indicatorView: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(style: .large)
    view.color = .papcornsWhite
    return view
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.Typography.heading3
    label.textColor = .papcornsWhite
    return label
  }()

  private func prepareLoadingView() {
    backgroundColor = UIColor.black.withAlphaComponent(0.8)

    outsideView.addSubview(indicatorView)
    indicatorView.startAnimating()
    addSubview(outsideView)
    addSubview(descriptionLabel)
    
    outsideView.snp.makeConstraints { make in
      make.width.height.equalTo(96)
      make.center.equalToSuperview()
    }
    
    indicatorView.snp.makeConstraints { make in
      make.width.height.equalTo(150)
      make.center.equalToSuperview()
    }

    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(indicatorView.snp.bottom)
      make.centerX.equalToSuperview()
    }
  }

  // MARK: Internal

  func updateMessage(_ message: String?) {
    descriptionLabel.text = message ?? "Media dosyası yükleniyor.."
  }
}
