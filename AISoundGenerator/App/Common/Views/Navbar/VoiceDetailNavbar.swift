//
//  VoiceDetailNavbar.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 4.11.2024.
//

import UIKit

class VoiceDetailNavbar: BaseView {

  var onTapBack: (() -> Void)?
  var onTapShare: (() -> Void)?
  var onTapCopyText: (() -> Void)?

  override func setupSubviews() {
    backgroundColor = .clear
    [backButton, titleLabel, optionsButton].forEach { addSubview($0) }
    setupMenu()
  }

  override func setupConstraints() {
    backButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.centerY.equalToSuperview()
      make.width.height.equalTo(24)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
    
    optionsButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-16)
      make.centerY.equalToSuperview()
      make.width.height.equalTo(24)
    }
  }
  
  private lazy var backButton: BaseButton = {
    let button = BaseButton()
    button.setImage(UIImage.Catalog.backIcon, for: .normal)
    button.onTap = { [weak self] in
      self?.onTapBack?()
    }
    return button
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Part Simpson"
    label.font = UIFont.Typography.subheading3
    label.textColor = .white
    return label
  }()
  
  private lazy var optionsButton: BaseButton = {
    let button = BaseButton()
    button.setImage(UIImage.Catalog.menuIcon, for: .normal)
    return button
  }()
  
  private func setupMenu() {
    let shareAction = UIAction(title: "Share", image: UIImage.Catalog.shareIcon) { _ in
      self.onTapShare?()
    }
    
    let copyAction = UIAction(title: "Copy Text", image: UIImage.Catalog.copyTextIcon) { _ in
      self.onTapCopyText?()
    }
    
    let menu = UIMenu(title: "", children: [shareAction, copyAction])
    optionsButton.menu = menu
    optionsButton.showsMenuAsPrimaryAction = true
  }
}
