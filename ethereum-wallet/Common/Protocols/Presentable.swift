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


protocol Presentable {
  
  var viewController: UIViewController { get }
  
  func present()
  func present(fromViewController viewController: UIViewController)
  func presentModal(fromViewController viewController: UIViewController)
  func show(fromViewController viewController: UIViewController)
  func dissmiss()
  func dissmissModal()
  func popToRoot()
}


extension Presentable where Self: UIViewController {
  
  var viewController: UIViewController {
    return self
  }
  
  func present() {
    AppDelegate.currentWindow.rootViewController = viewController
  }
  
  func present(fromViewController viewController: UIViewController) {
    viewController.navigationController?.pushViewController(self, animated: true)
  }
  
  func presentModal(fromViewController viewController: UIViewController) {
    viewController.present(self, animated: true, completion: nil)
  }
  
  func show(fromViewController viewController: UIViewController) {
    viewController.show(self, sender: viewController)
  }
  
  func dissmiss() {
    let _ = navigationController?.popViewController(animated: true)
  }
  
  func dissmissModal() {
    dismiss(animated: true, completion: nil)
  }
  
  func popToRoot() {
    viewController.navigationController?.popToRootViewController(animated: true)
  }
  
}
