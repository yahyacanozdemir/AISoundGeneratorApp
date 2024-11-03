//
//  StringExt.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import CoreFoundation
import UIKit

extension String {
  func calculateLabelWidth(with font: UIFont, maxHeight: CGFloat) -> CGFloat {
    let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: maxHeight)
    let attributes = [NSAttributedString.Key.font: font]
    let boundingRect = NSString(string: self).boundingRect(
      with: maxSize,
      options: .usesLineFragmentOrigin,
      attributes: attributes,
      context: nil)
    return ceil(boundingRect.width)
  }
}

extension String? {
  var isNilOrBlank: Bool {
    self == nil || self == ""
  }
}
