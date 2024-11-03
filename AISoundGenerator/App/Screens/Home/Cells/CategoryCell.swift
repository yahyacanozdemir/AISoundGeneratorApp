//
//  CategoryCell.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

class CategoryCell: BaseCollectionViewCell {

  override var isSelected: Bool {
    didSet {
      if isSelected {
        addBorder(color: .papcornsPink, width: 1)
      } else {
        removeBorder()
      }
    }
  }
  
  var name: String? {
    didSet {
      updateUI()
    }
  }

  override func setupSubviews() {
    addRadius(10)

    backgroundColor = .papcornsDark
    contentView.isUserInteractionEnabled = true
    contentView.addSubview(label)
  }

  override func setupConstraints() {
    label.snp.makeConstraints { make in
      make.centerY.centerX.equalToSuperview()
      make.height.equalTo(24)
    }
  }
  
  override func updateUI() {
    label.text = name
  }

  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
    -> UICollectionViewLayoutAttributes
  {
    let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
    let size = contentView.systemLayoutSizeFitting(
      targetSize,
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel)
    let updatedAttributes = layoutAttributes
    updatedAttributes.size.height = ceil(size.height)
    return updatedAttributes
  }

  // MARK: Private

  private lazy var label: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.Typography.body
    return label
  }()
}
