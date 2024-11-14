//
//  UIViewExt.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

extension UIView {  
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
