//
//  UIImageViewExt.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Foundation

import Kingfisher
import UIKit

extension UIImageView {
  
  func setImage(_ urlString: String?, placeholder: UIImage? = UIImage(named: "papcornsIcon")) {
    guard let urlString, let url = URL(string: urlString) else { return }
    
    kf.setImage(
      with: url,
      placeholder: placeholder,
      options: [
        .loadDiskFileSynchronously,
        .cacheOriginalImage,
        .transition(.fade(0.25)),
      ])
  }
}
