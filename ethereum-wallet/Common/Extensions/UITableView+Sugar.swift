// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


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
