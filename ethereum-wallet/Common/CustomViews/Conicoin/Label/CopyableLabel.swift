// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

class CopyableLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  func sharedInit() {
    isUserInteractionEnabled = true
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMenu(_:))))
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  
  override func copy(_ sender: Any?) {
    UIPasteboard.general.string = text
    UIMenuController.shared.setMenuVisible(false, animated: true)
  }
  
  @objc func showMenu(_ sender: AnyObject?) {
    becomeFirstResponder()
    let menu = UIMenuController.shared
    if !menu.isMenuVisible {
      let shareItem = UIMenuItem(title: "Share", action: #selector(share(_:)))
      menu.menuItems = [shareItem]
      menu.setTargetRect(bounds, in: self)
      menu.setMenuVisible(true, animated: true)
    }
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(copy(_:)) {
      return true
    } else if action == #selector(share(_:)) {
      return true
    }
    return false
  }
  
  @objc func share(_ sender: Any?) {
    guard let text = text, let parentViewController = parentViewController else { return }
    
    let controller = UIActivityViewController(activityItems: [text], applicationActivities: nil)
    parentViewController.present(controller, animated: true, completion: nil)
    UIMenuController.shared.setMenuVisible(false, animated: true)
  }
}

fileprivate extension UIView {
  var parentViewController: UIViewController? {
    var parentResponder: UIResponder? = self
    while parentResponder != nil {
      parentResponder = parentResponder!.next
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
    }
    return nil
  }
}


