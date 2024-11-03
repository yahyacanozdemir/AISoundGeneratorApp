//
//  BaseCollectionViewCell.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

// MARK: - BaseCollectionViewCell

class BaseCollectionViewCell: UICollectionViewCell, BindableLayout {

  // MARK: Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    bind()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  func bind() { }

  final func setupUI() {
    setupSubviews()
    setupConstraints()
  }

  func setupSubviews() { }

  func setupConstraints() { }
  
  func updateUI() { }
}
