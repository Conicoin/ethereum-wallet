// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

enum MnemonicVerificationStatus {
  case writtingDown
  case verifying
  case correct
  case incorrect
}

struct MnemonicViewState {
  var title: String!
  var subtitle: String!
  var mnemonicViewTitleColor: UIColor = .white
  var mnemonicViewBackgroundColor: UIColor!
  var okButtonTitle: String!
  var okButtonIsHidden: Bool!
  var skipButtonIsHidden: Bool = false
  var clearButtonHidden: Bool = true
  var hintButtonHidden: Bool = true
}


protocol MnemonicViewInput: class, Presentable {
  func setupInitialState()
  
  func update(with state: MnemonicViewState)
  
  func show(phrase: [String], shuffled: [String])
  func add(word: String)
  func clearWords()
  func removeLastWord()
  func setBottomMnemonicView(hidden: Bool, animated: Bool)
  func setClearButtonTitle(_ title: String)
}
