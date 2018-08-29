// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
