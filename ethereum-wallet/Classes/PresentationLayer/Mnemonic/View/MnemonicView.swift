//
//  MnemonicView.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Universa. All rights reserved.
//

import UIKit

// MARK: Private Multi-Device UI constants

fileprivate extension ScreenType {
  
  var scalableFont: UIFont {
    switch self {
    case .iPhone4, .iPhoneSE:
      return Theme.Font.regular14
    default:
      return Theme.Font.regular16
    }
  }
  
  var scalableInset: CGFloat {
    switch self {
    case .iPhone4, .iPhoneSE:
      return 5
    default:
      return 10
    }
  }
  
}

protocol MnemonicViewDelegate: class {
  func mnemonicView(_ view: MnemonicView, wordPressed word: String)
}

class MnemonicView: UIView {
  
  weak var delegate: MnemonicViewDelegate?
  
  var wordsPerLine = 4
  
  var selectedIndices: [Int] = []
  var wordButtons: [UIButton] = []
  var buttonTitleColor = Theme.Color.black
  var buttonBackgroundColor = UIColor.clear
  
  var lineStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.spacing = 12
    
    return stackView
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layer.cornerRadius = 12
    lineStackView.frame = bounds
    
    addSubview(lineStackView)
    
    lineStackView.translatesAutoresizingMaskIntoConstraints = false
    let top = lineStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
    let bottom = lineStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
    let leading = lineStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
    let trailing = lineStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
    NSLayoutConstraint.activate([top, bottom, leading, trailing])
  }
  
  // MARK: - API
  
  func show(phrase: [String]) {
    clear()
    
    for word in phrase {
      add(word: word)
    }
    
    layoutIfNeeded()
  }
  
  func add(word: String) {
    let button = createButton(with: word)
    let line = wordButtons.count / wordsPerLine
    
    let stackView = self.stackViewAndAdd(for: line)
    stackView.addArrangedSubview(button)
    
    wordButtons.append(button)
    
    layoutIfNeeded()
  }
  
  func clearLast() {
    guard let stackView = lineStackView.arrangedSubviews.last as? UIStackView else {
      return
    }
    
    if let view = stackView.arrangedSubviews.last, !wordButtons.isEmpty {
      view.removeFromSuperview()
      wordButtons.removeLast()
      layoutIfNeeded()
      
      if stackView.arrangedSubviews.count == 0 {
        lineStackView.arrangedSubviews.last?.removeFromSuperview()
      }
    }
  }
  
  func clear() {
    for stackView in lineStackView.arrangedSubviews {
      let stackView = stackView as! UIStackView
      for button in stackView.arrangedSubviews {
        stackView.removeArrangedSubview(button)
        button.removeFromSuperview()
      }
      lineStackView.removeArrangedSubview(stackView)
      stackView.removeFromSuperview()
    }
    
    wordButtons = []
  }
  
  func reset() {
    for stackView in lineStackView.arrangedSubviews {
      let stackView = stackView as! UIStackView
      for button in stackView.arrangedSubviews as! [UIButton] {
        button.isEnabled = true
      }
    }
    selectedIndices = []
  }
  
  func resetLast() {
    guard let index = selectedIndices.last, wordButtons.count > index else {
      return
    }
    
    let button = wordButtons[index]
    button.isEnabled = true
    
    selectedIndices.removeLast()
  }
  
  func set(titleColor: UIColor, backgroundColor: UIColor) {
    for stackView in lineStackView.arrangedSubviews {
      let stackView = stackView as! UIStackView
      for button in stackView.arrangedSubviews as! [UIButton] {
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
      }
    }
    
    buttonTitleColor = titleColor
    buttonBackgroundColor = backgroundColor
  }
  
  // MARK: - Private
  
  private func addStackView(for line: Int) {
    let stackView = createStackView()
    lineStackView.addArrangedSubview(stackView)
  }
  
  private func stackViewAndAdd(for line: Int) -> UIStackView {
    if lineStackView.arrangedSubviews.count <= line {
      addStackView(for: line)
    }
    return lineStackView.arrangedSubviews.last as! UIStackView
  }
  
  private func createStackView() -> UIStackView {
    let stackView = UIStackView(frame: .zero)
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 16
    
    return stackView
  }
  
  private func createButton(with text: String) -> UIButton {
    let button = ResponsiveButton(frame: .zero)
    button.setTitle(text, for: .normal)
    button.setTitleColor(buttonTitleColor, for: .normal)
    button.setTitleColor(buttonBackgroundColor, for: .disabled)
    button.titleLabel?.font = UIDevice.screenType.scalableFont
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.minimumScaleFactor = 0.5
    button.backgroundColor = buttonBackgroundColor
    let inset = UIDevice.screenType.scalableInset
    button.contentEdgeInsets = UIEdgeInsetsMake(6, inset, 4, inset)
    button.layer.cornerRadius = 12
    button.addTarget(self, action: #selector(wordPressed(sender:)), for: .touchUpInside)
    
    return button
  }
  
  @objc func wordPressed(sender: UIButton) {
    sender.isEnabled = false
    
    selectedIndices.append(wordButtons.index(of: sender)!)
    delegate?.mnemonicView(self, wordPressed: sender.titleLabel!.text!)
  }
  
}
