//
//  MnemonicMnemonicViewInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
  var skipButtonIsHidden: Bool = false
  var clearButtonHidden: Bool = true
  var hintButtonHidden: Bool = true
}


protocol MnemonicViewInput: class, Presentable {
  func setupInitialState()
  
  func update(with state: MnemonicViewState)
  
  func show(phrase: [String], shuffled: [String])
  func add(word: String)
  func clear()
  func setBottomMnemonicView(hidden: Bool, animated: Bool)
}
