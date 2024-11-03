//
//  DefaultNavBarView.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

class DefaultNavBarView: BaseView {

  init(title: String = "", type: NavBarType = .backButton) {
    navBarTitle = title
    self.type = type
    super.init()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  var onTapBackButton: (() -> Void)?

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.Typography.bodyBld
    label.textColor = .white
    return label
  }()

  override func setupSubviews() {
    backgroundColor = .clear
    titleLabel.text = navBarTitle
    
    if type == .backButton {
      addSubview(backButton)
    } else {
      addSubview(titleLabel)
    }
  }

  override func setupConstraints() {
    if type == .backButton {
      backButton.snp.makeConstraints { make in
        make.width.height.equalTo(24)
        make.leading.equalToSuperview().offset(16)
        make.centerY.equalToSuperview()
      }
    } else {
      titleLabel.snp.makeConstraints { make in
        make.center.equalToSuperview()
        make.height.equalTo(22)
      }
    }
  }

  // MARK: Private

  private var type: NavBarType
  private var navBarTitle: String
  
  private lazy var backButton: BaseButton = {
    let button = BaseButton()
    button.setImage(UIImage(named: "xIcon"), for: .normal)
    button.onTap = {
      self.backTapped()
    }
    return button
  }()
  
  private func backTapped() {
    self.onTapBackButton?()
  }
}

// MARK: - NavBarType

enum NavBarType {
  case backButton
  case onlyTitle
}
