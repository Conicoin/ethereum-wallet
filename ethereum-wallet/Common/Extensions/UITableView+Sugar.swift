// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

extension UITableView {
  func register<T: UITableViewCell> (_ cellClass: T.Type) {
    self.register(cellClass, forCellReuseIdentifier: cellClass.identifier())
  }
  
  func registerNib<T: UITableViewCell>(_ cellClass: T.Type) {
    let nib = UINib(nibName: cellClass.identifier(), bundle: nil)
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
  
  
  func dequeue<T: UITableViewCell>(_ cellClass: T.Type) -> T {
    guard let cell = self.dequeueReusableCell(
      withIdentifier: cellClass.identifier()) as? T else {
        fatalError("Error: cannot dequeue cell with identifier: \(cellClass.identifier())")
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
