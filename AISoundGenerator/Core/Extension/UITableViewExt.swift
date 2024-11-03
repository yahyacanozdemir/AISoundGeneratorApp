//
//  UITableViewExt.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024
//

import UIKit

extension UITableView {

  func registerCells(cellTypes: [(some UITableViewCell).Type], bundle _: Bundle? = nil) {
    cellTypes.forEach { register(with: $0) }
  }

  func register(with cellClass: AnyClass) {
    register(cellClass, forCellReuseIdentifier: String(describing: cellClass.self))
  }

  func dequeueCell<T>(withClassAndIdentifier _: T.Type, for indexPath: IndexPath) -> T {
    dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
  }

  func registerHeaderFooter(with viewClass: AnyClass, reuseIdentifier: String? = nil) {
    let identifier = reuseIdentifier ?? String(describing: viewClass.self)
    register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
  }

  func dequeueHeaderFooter<T>(viewClass: T.Type, reuseIdentifier: String? = nil) -> T {
    let identifier = reuseIdentifier ?? String(describing: viewClass.self)
    return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
  }
}
