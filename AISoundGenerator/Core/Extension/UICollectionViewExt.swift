//
//  UICollectionViewExt.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import UIKit

extension UICollectionView {

  func registerCells(cellTypes: [(some UICollectionViewCell).Type], bundle _: Bundle? = nil) {
    cellTypes.forEach { register(with: $0) }
  }

  func register(with cellClass: AnyClass) {
    register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass.self))
  }

  func dequeueCell<T>(withClassAndIdentifier _: T.Type, for indexPath: IndexPath) -> T {
    dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
  }

  func registerSupplementaryView(with viewClass: AnyClass, elementKind: String) {
    register(
      viewClass,
      forSupplementaryViewOfKind: elementKind,
      withReuseIdentifier: String(describing: viewClass.self))
  }

  func dequeueReusableView<T: UICollectionReusableView>(
    with _: T.Type,
    for indexPath: IndexPath,
    ofKind kind: String = UICollectionView.elementKindSectionHeader)
    -> T
  {
    dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: self), for: indexPath) as! T
  }
}
