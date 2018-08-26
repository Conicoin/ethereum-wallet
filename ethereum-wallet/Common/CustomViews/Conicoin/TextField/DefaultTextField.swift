//
//  DefaultTextField.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 10/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit
import CoreText

class DefaultTextField: UIView {
  static var stringTransformer: ((String) -> String?)! = {
    orginal in
    return orginal
  }
  static var instanceTransformer: ((DefaultTextField) -> Void)! = {
    orginal in
  }
  
  public enum State {
    case idle, float
  }
  
  @IBInspectable var placeholder: String = "" {
    didSet {
      placeHolderLabel.string = DefaultTextField.stringTransformer(placeholder)
    }
  }
  
  var applyTransform: Bool = true
  var leftInset: CGFloat = 0
  var rightInset: CGFloat = 0
  var textInnerPadding: CGFloat = 2
  var imageInnerPadding: CGFloat = 8
  
  var iconImage: UIImage? = nil
  var iconSize: CGFloat = 30
  
  var idlePlaceHolderColor: UIColor = Theme.Color.gray
  var floatPlaceHolderColor: UIColor = Theme.Color.gray
  var textColor: UIColor = Theme.Color.black
  var idlePlaceHolderFont: UIFont = Theme.Font.regular16
  var floatPlaceHolderFont: UIFont = Theme.Font.regular12
  var inputFont: UIFont = Theme.Font.regular16
  var separatorEnabled: Bool = true
  var separatorColor: UIColor = Theme.Color.blue
  var separatorLeftInset: CGFloat = 0
  var separatorRightInset: CGFloat = 0
  var separatorHeight: CGFloat = 2
  
  var animationDuration: Double = 0.1
  
  var iconImageView = UIImageView()
  var placeHolderLabel = CATextLayer()
  var textField = UITextField()
  var separatorView = UIView()
  var state: State = State.idle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    build()
  }
  
  func build() {
    placeHolderLabel.contentsScale = UIScreen.main.scale
    addSubview(textField)
    addSubview(iconImageView)
    addSubview(separatorView)
    layer.addSublayer(placeHolderLabel)
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(focus)))
    textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    if applyTransform { DefaultTextField.instanceTransformer(self) }
    configFontsAndColors()
    changeToIdle(animated: false)
    
    textField.autocorrectionType = .no
    textField.autocapitalizationType = .none
    textField.spellCheckingType = .no
    textField.smartQuotesType = .no
    textField.returnKeyType = .done
    textField.enablesReturnKeyAutomatically = true
  }
  
  func configFontsAndColors() {
    placeHolderLabel.font = floatPlaceHolderFont
    textField.textColor = textColor
    textField.font = inputFont
    textField.tintColor = tintColor
    separatorView.backgroundColor = separatorColor
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layout()
  }
  
  func layout() {
    var currentX: CGFloat = leftInset
    if let iconImage = iconImage {
      iconImageView.isHidden = false
      iconImageView.image = iconImage
      iconImageView.frame = CGRect(x: currentX, y: viewHeight.half - iconSize.half, width: iconSize, height: iconSize)
      currentX += iconSize + imageInnerPadding
    } else {
      iconImageView.isHidden = true
    }
    let placeHolderUIFont = state == .idle ? idlePlaceHolderFont : floatPlaceHolderFont
    let placeHolderHeight: CGFloat = placeHolderUIFont.lineHeight + 2
    let textFieldHeight = textField.font!.lineHeight + 2
    let inputHeight = placeHolderHeight + textInnerPadding + textFieldHeight
    let widthForInput = viewWidth - currentX - rightInset
    if state == .idle {
      placeHolderLabel.frame = CGRect(x: currentX, y: viewHeight.half - placeHolderHeight.half, width: widthForInput, height: idlePlaceHolderFont.lineHeight + 4)
    } else {
      placeHolderLabel.frame = CGRect(x: currentX, y: viewHeight.half - inputHeight.half - 12, width: widthForInput, height: idlePlaceHolderFont.lineHeight + 4)
    }
    textField.frame = CGRect(x: currentX, y: viewHeight.half + inputHeight.half - textFieldHeight - 8, width: widthForInput, height: textFieldHeight)
    
    separatorView.isHidden = !separatorEnabled
    separatorView.frame = CGRect(x: separatorLeftInset, y: viewHeight - separatorHeight, width: viewWidth - separatorLeftInset - separatorRightInset, height: separatorHeight)
  }
  
  func changeToFloat(animated: Bool) {
    let animationDuration = animated ? self.animationDuration : 0.0
    state = .float
    CATransaction.begin()
    CATransaction.setAnimationDuration(animationDuration)
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
    placeHolderLabel.foregroundColor = floatPlaceHolderColor.cgColor
    placeHolderLabel.fontSize = floatPlaceHolderFont.lineHeight
    layout()
    CATransaction.commit()
    UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut
      , animations: {
        self.textField.alpha = 1.0
    }, completion: nil)
  }
  
  func changeToIdle(animated: Bool) {
    let animationDuration = animated ? self.animationDuration : 0.0
    state = .idle
    CATransaction.begin()
    CATransaction.setAnimationDuration(animationDuration)
    CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
    placeHolderLabel.foregroundColor = idlePlaceHolderColor.cgColor
    placeHolderLabel.fontSize = idlePlaceHolderFont.lineHeight
    layout()
    CATransaction.commit()
    UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut
      , animations: {
        self.textField.alpha = 0.0
    }, completion: nil)
  }
  
  @objc func focus() {
    textField.becomeFirstResponder()
    changeToFloat(animated: true)
  }
  
  @objc func editingDidEnd() {
    if let text = textField.text, text.count > 0 {
      changeToFloat(animated: true)
    } else {
      changeToIdle(animated: true)
    }
  }
  
}
