//
//  UITableView+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

extension UITableView {
  func register<T: UITableViewCell> (_ cellClass: T.Type) {
    self.register(cellClass, forCellReuseIdentifier: cellClass.identifier())
  }
  
  func register<T: UITableViewCell>(_ nib: UINib, forClass cellClass: T.Type) {
    self.register(nib, forCellReuseIdentifier: cellClass.identifier())
  }
  
  func dequeue<T: UITableViewCell>(_ cellClass:
    T.Type, for indexPath: IndexPath) -> T {
    guard let cell = self.dequeueReusableCell(
      withIdentifier: cellClass.identifier(), for: indexPath) as? T else {
        fatalError("Error: cannot dequeue cell with identifier: \(cellClass.identifier()) " +
          "for index path: \(indexPath)")
    }
    return cell
  }
  func register<T: UITableViewHeaderFooterView>(_ headerFooterClass: T.Type) {
    self.register(headerFooterClass,
                  forHeaderFooterViewReuseIdentifier: headerFooterClass.identifier())
  }
  
  func register<T: UITableViewHeaderFooterView>(_ nib: UINib,
                                                forHeaderFooterClass headerFooterClass: T.Type) {
    self.register(nib, forHeaderFooterViewReuseIdentifier: headerFooterClass.identifier())
  }
  
  func dequeue<T: UITableViewHeaderFooterView>(_ headerFooterClass: T.Type) -> T? {
    return dequeueReusableHeaderFooterView(withIdentifier: headerFooterClass.identifier()) as? T
  }
}

fileprivate extension UITableViewCell {
  class func identifier() -> String {
    return String(NSStringFromClass(self).split(separator: ".").last!)
  }
}

fileprivate extension UITableViewHeaderFooterView {
  class func identifier() -> String {
    return String(NSStringFromClass(self).split(separator: ".").last!)
  }
}
