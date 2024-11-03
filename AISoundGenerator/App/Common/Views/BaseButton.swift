//
//  BaseButton.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 1.11.2024.
//

import Foundation
import UIKit

class BaseButton: UIButton {
  
  // MARK: Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setCornerRadius()
    setTitle()
    setColor()
    setTitleColor()
    setDisabled()
    
    addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Internal
  
  enum ButtonSize {
    case small, medium, fullWidth, sizeToFit
  }
  
  var onTap: (() -> Void)?
  var size: ButtonSize = .sizeToFit
  
  var allowSuccessiveTouch = false
  
  var isUnderlined = false {
    didSet {
      setTitle()
    }
  }
  
  var cornerRadius: CGFloat = 4.0 {
    didSet {
      setCornerRadius()
    }
  }
  
  var title: String? = nil {
    didSet {
      setTitle()
    }
  }
  
  var color = UIColor.clear {
    didSet {
      setColor()
    }
  }
  
  var titleColor = UIColor.papcornsWhite {
    didSet {
      setTitleColor()
    }
  }
  
  var isDisabled = false {
    didSet {
      setDisabled()
      setTitleColor()
      setColor()
      setGradientColor()
    }
  }
  
  var isGradientButton = false
  
  private lazy var gradientLayer: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.frame = self.bounds
    gradient.colors = isDisabled ? [UIColor.buttonDisable.cgColor, UIColor.buttonDisable.cgColor] : [UIColor.papcornsPink.cgColor, UIColor.papcornsPurple.cgColor]
    gradient.startPoint = CGPoint(x: 0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1, y: 0.5)
    gradient.cornerRadius = 16
    layer.insertSublayer(gradient, at: 0)
    return gradient
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if isGradientButton {
      gradientLayer.bounds = bounds
    }
  }
  
  // MARK: Private
  
  @objc
  private func buttonTapped() {
    onTap?()
  }
}

extension BaseButton {
  
  // MARK: Internal
  
  func setTitle() {
    if let title {
      if isUnderlined {
        setAttributedTitle(NSAttributedString(string: title, attributes: [
          .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]), for: .normal)
      } else {
        setTitle(title, for: .normal)
      }
    } else {
      setTitle(nil, for: .normal)
    }
  }
  
  // MARK: Private
  
  private func setColor() {
    let color = isDisabled ? color.withAlphaComponent(0.30) : color

    backgroundColor = color
  }
  
  private func setGradientColor() {
    if isGradientButton {
      gradientLayer.colors = isDisabled ? [UIColor.buttonDisable.cgColor, UIColor.buttonDisable.cgColor] : [UIColor.papcornsPink.cgColor, UIColor.papcornsPurple.cgColor]
    }
  }
  
  private func setTitleColor() {
    let color = isDisabled ? UIColor.papcornsWhite50 : titleColor
    
    setTitleColor(color, for: .normal)
  }
  
  private func setDisabled() {
    isEnabled = !isDisabled
  }
  
  
  private func setCornerRadius() {
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = true
  }
}
