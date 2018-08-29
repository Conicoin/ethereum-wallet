/*

 Copyright DApps Platform Inc. All rights reserved.
 
 */

import UIKit

class BorderView: UIView {
  private let initialImageView = UIImageView()
  private let scrolledImageView = UIImageView()
  
  private let separatorImage = UIImage(color: UIColor(red: 206.0/255.0, green: 213.0/255.0, blue: 219.0/255.0, alpha: 0.48))
  private let shadowImage = UIImage(named: "HeaderShadow")
  
  var initialImage: UIImage? {
    get { return initialImageView.image }
    set {
      initialImageView.image = newValue
      setNeedsLayout()
    }
  }
  
  var scrolledImage: UIImage? {
    get { return scrolledImageView.image }
    set {
      scrolledImageView.image = newValue
      setNeedsLayout()
    }
  }
  
  var progress: CGFloat = 0 {
    didSet {
      if progress != oldValue {
        updateProgress()
      }
    }
  }
  
  var topInset: CGFloat = 0
  var offsetThreshold: CGFloat = 48
  
  var borderOffset: CGFloat = 0
  
  private weak var scrollView: UIScrollView! = .none
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func attach(to view: UIScrollView) {
    scrollView = view
    scrollView.addObserver(self, forKeyPath: "bounds", options: .new, context: &KVOContext.bounds)
    scrollView.addSubview(self)
    updateFrame()
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
    guard let scrollView = scrollView, context == &KVOContext.bounds else {
      super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
      return
    }
    
    scrollView.bringSubview(toFront: self)
    updateFrame()
  }
  
  override func removeFromSuperview() {
    superview?.removeObserver(self, forKeyPath: "bounds", context: &KVOContext.bounds)
    super.removeFromSuperview()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    for imageView in [initialImageView, scrolledImageView] {
      imageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: imageView.image?.size.height ?? 0)
    }
  }
}

private extension BorderView {
  
  struct KVOContext {
    static var bounds = true
  }
  
  func setupView() {
    addSubview(initialImageView)
    addSubview(scrolledImageView)
    scrolledImage = shadowImage
    isUserInteractionEnabled = false
    updateProgress()
  }
  
  func updateFrame() {
    guard let scrollView = scrollView else {
      return
    }
    let position = CGPoint(x: scrollView.bounds.origin.x, y: scrollView.bounds.origin.y + topInset)
    frame = CGRect(origin: position, size: CGSize(width: scrollView.bounds.width, height: 16))
    progress = min(1, max(0, (scrollView.bounds.origin.y) - borderOffset) / offsetThreshold)
  }
  
  func updateProgress() {
    initialImageView.alpha = 1 - progress
    scrolledImageView.alpha = progress
  }
}
