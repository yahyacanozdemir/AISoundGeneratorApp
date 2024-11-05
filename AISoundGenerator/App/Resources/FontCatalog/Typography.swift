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
      // bold
       static let heading1 = UIFont.sfPro(style: .bold700, size: 34, lineHeight: 42)
       static let heading2 = UIFont.sfPro(style: .bold700, size: 26, lineHeight: 32)
       static let heading3 = UIFont.sfPro(style: .bold700, size: 17, lineHeight: 22)
       
       // semibold
       static let subheading1 = UIFont.sfPro(style: .semiBold600, size: 34, lineHeight: 42)
       static let subheading2 = UIFont.sfPro(style: .semiBold600, size: 26, lineHeight: 32)
       static let subheading3 = UIFont.sfPro(style: .semiBold600, size: 17, lineHeight: 22)
       static let subheading4 = UIFont.sfPro(style: .semiBold600, size: 15, lineHeight: 20)
       
       // regular
       static let bodyLg = UIFont.sfPro(style: .regular400, size: 17, lineHeight: 22)
       static let bodyMLg = UIFont.sfPro(style: .regular400, size: 17, lineHeight: 20)
       static let bodyMd = UIFont.sfPro(style: .regular400, size: 15, lineHeight: 19)
       static let bodySm = UIFont.sfPro(style: .regular400, size: 13, lineHeight: 18)
       static let captionSm = UIFont.sfPro(style: .regular400, size: 12, lineHeight: 16)
  }
}

extension UIFont {
  enum SFProStyle: String {
    case regular400 = "SFProDisplay-Regular"
    case semiBold600 = "SFProDisplay-Semibold"
    case bold700 = "SFProDisplay-Bold"
  }

  static func sfPro(style: SFProStyle, size: CGFloat, lineHeight: CGFloat? = nil) -> UIFont {
    guard let font = UIFont(name: style.rawValue, size: size) else {
      switch style {
      case .bold700, .semiBold600:
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
