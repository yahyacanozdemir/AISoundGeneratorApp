//
//  Typography.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 1.11.2024.
//

import UIKit

// MARK: - UIFont.Typography

extension UIFont {
  enum Typography {
    static let titleLarge2 = UIFont.sfPro(style: .bold, size: 34, lineHeight: 42)
    static let titleLarge = UIFont.sfPro(style: .semibold, size: 34, lineHeight: 42)
    static let titleMedium = UIFont.sfPro(style: .bold, size: 22, lineHeight: 28)
    
    static let bodyBld = UIFont.sfPro(style: .bold, size: 17, lineHeight: 22)
    
    static let title1 = UIFont.sfPro(style: .semibold, size: 26, lineHeight: 32)

    static let bodySmb6 = UIFont.sfPro(style: .semibold, size: 17, lineHeight: 22)
    static let bodySmb5 = UIFont.sfPro(style: .semibold, size: 16, lineHeight: 22)
    static let bodySmb4 = UIFont.sfPro(style: .semibold, size: 15, lineHeight: 22)
    static let bodySmb3 = UIFont.sfPro(style: .semibold, size: 14, lineHeight: 22)
    static let bodySmb2 = UIFont.sfPro(style: .semibold, size: 13, lineHeight: 22)
    static let bodySmb1 = UIFont.sfPro(style: .semibold, size: 12, lineHeight: 22)

    
    static let body6 = UIFont.sfPro(style: .regular, size: 17, lineHeight: 22)
    static let body5 = UIFont.sfPro(style: .regular, size: 16, lineHeight: 22)
    static let body4 = UIFont.sfPro(style: .regular, size: 15, lineHeight: 22)
    static let body3 = UIFont.sfPro(style: .regular, size: 14, lineHeight: 22)
    static let body2 = UIFont.sfPro(style: .regular, size: 13, lineHeight: 22)
    static let body1 = UIFont.sfPro(style: .regular, size: 12, lineHeight: 22)


    static let caption = UIFont.sfPro(style: .semibold, size: 11, lineHeight: 13)
  }
}

extension UIFont {
  enum SFProStyle: String {
    case bold = "SFProDisplay-Bold"
    case semibold = "SFProDisplay-Semibold"
    case regular = "SFProDisplay-Regular"
  }

  static func sfPro(style: SFProStyle, size: CGFloat, lineHeight: CGFloat? = nil) -> UIFont {
    guard let font = UIFont(name: style.rawValue, size: size) else {
      switch style {
      case .bold, .semibold:
        return UIFont.boldSystemFont(ofSize: size).withLineHeight(lineHeight ?? 0)
      default:
        return UIFont.systemFont(ofSize: size).withLineHeight(lineHeight ?? 0)
      }
    }

    return font
  }
  
  func withLineHeight(_ lineHeight: CGFloat) -> UIFont {
    let newFontDescriptor = fontDescriptor.addingAttributes([.name: fontName, .size: pointSize, .family: familyName])
    let newFont = UIFont(descriptor: newFontDescriptor, size: lineHeight)
    return newFont
  }
}
