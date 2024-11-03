//
//  UIColorExt.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

//extension UIColor {
//
//  static let papcornsWhite = UIColor.fromAsset(named: "white")
//  static let papcornsWhite50 = UIColor.fromAsset(named: "white50")
//  static let papcornsWhite70 = UIColor.fromAsset(named: "white70")
//  static let papcornsWhite85 = UIColor.fromAsset(named: "white85")
//
//  static let papcornsGray = UIColor.fromAsset(named: "gray")
//  static let papcornsBlack = UIColor.fromAsset(named: "black")
//  static let papcornsDark = UIColor.fromAsset(named: "dark")
//
//  static let papcornsPink = UIColor.fromAsset(named: "pink")
//  static let papcornsPink30 = UIColor.fromAsset(named: "pink30")
//  static let papcornsPurple = UIColor.fromAsset(named: "purple")
//  static let papcornsPurple30 = UIColor.fromAsset(named: "purple30")
//
//}
//
//extension UIColor {
//  static func fromAsset(named name: String) -> UIColor {
//    guard let color = UIColor(named: name) else {
//      print("Cannot find color named '\(name)' in asset catalog")
//      return .clear
//    }
//    return color
//  }
//}

extension UIColor {
  static func primaryGradientColor() -> [CGColor] {
    return [UIColor.papcornsPink30.cgColor, UIColor.papcornsPurple30.cgColor]
  }
}

extension UIColor {
  static func applyGradientColors(bounds: CGRect, colors: [UIColor]) -> UIColor? {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = colors.map { $0.cgColor }
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image.flatMap { UIColor(patternImage: $0) }
  }
}
