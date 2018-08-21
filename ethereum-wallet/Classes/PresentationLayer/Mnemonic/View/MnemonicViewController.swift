//
//  MnemonicMnemonicViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class MnemonicViewController: UIViewController {
  
  var output: MnemonicViewOutput!
  
  @IBOutlet weak var skipButton: UIBarButtonItem!
  @IBOutlet var mnemonicTitleLabel: UILabel!
  @IBOutlet var mnemonicSubtitleLabel: UILabel!
  @IBOutlet var mnemonicHintButton: UIButton!
  @IBOutlet var mnemonicView: MnemonicView!
  @IBOutlet var bottomMnemonicView: MnemonicView!
  @IBOutlet var bottomMnemonicConstraint: NSLayoutConstraint!
  
  @IBOutlet var clearButton: UIButton!
  @IBOutlet var okButton: UIButton!
  
  func update(with state: MnemonicViewState) {
    mnemonicView.set(titleColor: state.mnemonicViewTitleColor, backgroundColor: state.mnemonicViewBackgroundColor)
    
    mnemonicTitleLabel.text = state.title
    mnemonicSubtitleLabel.text = state.subtitle
    
    okButton.setTitle(state.okButtonTitle, for: .normal)
    clearButton.isHidden = state.clearButtonHidden
    mnemonicHintButton.isHidden = state.hintButtonHidden
  }
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.hidesBackButton = true
    output.viewIsReady()
  }
  
  // MARK: Actions
  
  @IBAction func okPressed() {
    output.okPressed()
  }
  
  @IBAction func mnemonicHintPressed() {
    
  }
  
  @IBAction func skipPressed(_ sender: UIBarButtonItem) {
    output.skipPressed()
  }
  
  @IBAction func clearPressed() {
    output.clearPressed()
  }
}


// MARK: - MnemonicViewInput

extension MnemonicViewController: MnemonicViewInput {
  
  func setupInitialState() {
    mnemonicView.isUserInteractionEnabled = false
    clearButton.isHidden = true
    bottomMnemonicView.delegate = self
    bottomMnemonicView.set(titleColor: Theme.Color.black, backgroundColor: Theme.Color.lightGray)
    setBottomMnemonicView(hidden: true, animated: false)
  }
  
  func show(phrase: [String], shuffled: [String]) {
    mnemonicView.show(phrase: phrase)
    bottomMnemonicView.show(phrase: shuffled)
  }
  
  func add(word: String) {
    mnemonicView.add(word: word)
  }
  
  func clear() {
    mnemonicView.clear()
    bottomMnemonicView.reset()
  }
  
  func setBottomMnemonicView(hidden: Bool, animated: Bool) {
    bottomMnemonicConstraint.constant = hidden ? -bottomMnemonicView.frame.height : 0
    if animated {
      UIView.animate(withDuration: 0.2) {
        self.bottomMnemonicView.alpha = hidden ? 0 : 1
        self.view.layoutIfNeeded()
      }
    } else {
      self.bottomMnemonicView.alpha = hidden ? 0 : 1
      view.layoutIfNeeded()
    }
  }
  
}

// MARK: - MnemonicViewDelegate

extension MnemonicViewController: MnemonicViewDelegate {
  
  func mnemonicView(_ view: MnemonicView, wordPressed word: String) {
    output.wordPressed(word)
  }
  
}
