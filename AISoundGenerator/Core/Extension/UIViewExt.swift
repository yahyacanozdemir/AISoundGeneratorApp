//
//  UIViewExt.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

extension UIView {
  func applyPapcornsLinear() -> CAGradientLayer {
    return self.applyGradient(colours: [.papcornsPink, .papcornsPurple], locations: [])
  }
  
  func applyPapcornsPrimaryLinear() -> CAGradientLayer {
    return self.applyGradient(colours: [.papcornsPink30, .papcornsPurple30], locations: nil)
  }
  
  func applyGradient(colours: [UIColor]) -> CAGradientLayer {
    return self.applyGradient(colours: colours, locations: nil)
  }
  
  
  func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.frame = self.bounds
    gradient.colors = colours.map { $0.cgColor }
    gradient.locations = locations
    self.layer.insertSublayer(gradient, at: 0)
    return gradient
  }
  
  func addRadius(
    _ radius: CGFloat,
    corners: CACornerMask = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner])
  {
    layer.masksToBounds = false
    layer.cornerRadius = radius
    layer.maskedCorners = corners
  }
  
  func addBorder(color: UIColor, width: CGFloat) {
    layer.borderColor = color.cgColor
    layer.borderWidth = width
  }
  
  func removeBorder() {
    layer.borderColor = UIColor.clear.cgColor
    layer.borderWidth = 0
  }
}
