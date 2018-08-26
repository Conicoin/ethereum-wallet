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
  
  @IBOutlet var skipButton: UIButton!
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
    skipButton.isHidden = state.skipButtonIsHidden
    okButton.isHidden = state.okButtonIsHidden
  }
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  // MARK: - Privates
  
  private func localize() {
    clearButton.setTitle(Localized.mnemonicCommonCancel(), for: .normal)
    skipButton.setTitle(Localized.commonNotNow(), for: .normal)
  }
  
  // MARK: Actions
  
  @IBAction func okPressed() {
    output.okPressed()
  }
  
  @IBAction func mnemonicHintPressed() {
    
  }
  
  @IBAction func skipPressed(_ sender: UIButton) {
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
  
  func clearWords() {
    mnemonicView.clear()
    bottomMnemonicView.reset()
  }
  
  func removeLastWord() {
    mnemonicView.clearLast()
    bottomMnemonicView.resetLast()
  }
  
  func setClearButtonTitle(_ title: String) {
    clearButton.setTitle(title, for: .normal)
  }
  
  func setBottomMnemonicView(hidden: Bool, animated: Bool) {
    bottomMnemonicConstraint.constant = hidden ? -bottomMnemonicView.frame.height : 24
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
