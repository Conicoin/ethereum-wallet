// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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

extension UICollectionView {
  func registerClass<T: UICollectionViewCell> (_ cellClass: T.Type) {
    register(cellClass, forCellWithReuseIdentifier: cellClass.identifier())
  }
  
  func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
    let nib = UINib(nibName: cellClass.identifier(), bundle: nil)
    register(nib, forCellWithReuseIdentifier: cellClass.identifier())
  }
  
  func dequeue<T: UICollectionViewCell>(_ cellClass:
    T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(
      withReuseIdentifier: cellClass.identifier(), for: indexPath) as? T else {
        fatalError("Error: cannot dequeue cell with identifier: \(cellClass.identifier()) " +
          "for index path: \(indexPath)")
    }
    return cell
  }
  
  func registerClass<T: UICollectionReusableView>(_ headerFooterClass: T.Type, kind: String) {
    register(headerFooterClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: headerFooterClass.reuseId())
  }
  
  func registerNib<T: UICollectionReusableView>(_ headerFooterClass: T.Type, kind: String) {
    let nib = UINib(nibName: headerFooterClass.reuseId(), bundle: nil)
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: headerFooterClass.reuseId())
  }
  
  func dequeue<T: UICollectionReusableView>(_ headerFooterClass: T.Type, kind: String, for indexPath: IndexPath) -> T? {
    return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerFooterClass.reuseId(), for: indexPath) as? T
  }
}

fileprivate extension UICollectionViewCell {
  class func identifier() -> String {
    return String(NSStringFromClass(self).split(separator: ".").last!)
  }
}

fileprivate extension UICollectionReusableView {
  class func reuseId() -> String {
    return String(NSStringFromClass(self).split(separator: ".").last!)
  }
}
