//
//  MnemonicMnemonicPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

enum MnemonicState {
  case create
  case backup
  
  var title: String {
    switch self {
    case .create:
      return Localized.mnemonicWritingCreateTitle()
    case .backup:
      return Localized.mnemonicWritingBackupTitle()
    }
  }
}

class MnemonicPresenter {
  
  var view: MnemonicViewInput!
  weak var output: MnemonicModuleOutput?
  var interactor: MnemonicInteractorInput!
  var router: MnemonicRouterInput!
  
  var mnemonic: [String]!
  var mnemonicState: MnemonicState!
  var completion: ((UIViewController) -> Void)?
  
  var currentPhrase: [String] = [] {
    didSet {
      updateClearButton()
    }
  }
  
  var status = MnemonicVerificationStatus.writtingDown {
    didSet {
      view.update(with: stateForCurrentStatus())
    }
  }
  
  var finished: Bool {
    return currentPhrase.count >= mnemonic.count
  }
  
  var correct: Bool {
    return currentPhrase == mnemonic
  }
  
  func add(word: String) {
    currentPhrase.append(word)
  }
  
  func clearWords() {
    currentPhrase = []
  }
  
  func removeLast() {
    if !currentPhrase.isEmpty {
      currentPhrase.removeLast()
    }
  }
  
  func updateClearButton() {
    if currentPhrase.isEmpty {
      view.setClearButtonTitle(Localized.mnemonicCommonCancel())
    } else {
      view.setClearButtonTitle(Localized.mnemonicCommonDelete())
    }
  }
  
  func stateForCurrentStatus() -> MnemonicViewState {
    var state = MnemonicViewState()
    
    switch status {
      
    case .writtingDown:
      state.title = mnemonicState.title
      state.subtitle = Localized.mnemonicWritingSubtitle()
      state.mnemonicViewTitleColor = Theme.Color.black
      state.mnemonicViewBackgroundColor = .clear
      state.okButtonTitle = Localized.mnemonicWritingButtonTitle()
      state.hintButtonHidden = false
      state.okButtonIsHidden = false
      
    case .verifying:
      state.title = ""
      state.subtitle = Localized.mnemonicVerifyingSubtitle()
      state.mnemonicViewBackgroundColor = Theme.Color.blue
      state.okButtonTitle = ""
      state.clearButtonHidden = false
      state.okButtonIsHidden = true
      
    case .correct:
      state.title = Localized.mnemonicCorrectTitle()
      state.subtitle = Localized.mnemonicCorrectSubtitle()
      state.mnemonicViewBackgroundColor = Theme.Color.green
      state.okButtonTitle = Localized.mnemonicCorrectButtonTitle()
      state.skipButtonIsHidden = true
      state.okButtonIsHidden = false
      
    case .incorrect:
      state.title = Localized.mnemonicIncorrectTitle()
      state.subtitle = Localized.mnemonicIncorrectSubtitle()
      state.mnemonicViewBackgroundColor = Theme.Color.red
      state.okButtonTitle = Localized.mnemonicIncorrectButtonTitle()
      state.okButtonIsHidden = false
    }
    
    return state
  }
}


// MARK: - MnemonicViewOutput

extension MnemonicPresenter: MnemonicViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    status = .writtingDown
    interactor.getMnemonic()
  }
  
  func backPressed() {
    view.dissmiss()
  }
  
  func okPressed() {
    switch status {
      
    case .writtingDown:
      view.setBottomMnemonicView(hidden: false, animated: true)
      view.clearWords()
      
      status = .verifying
      
    case .verifying:
      break
      
    case .correct:
      interactor.setWalletBackuped()
      completion?(view.viewController)
      
    case .incorrect:
      view.show(phrase: mnemonic, shuffled: mnemonic.shuffled())
      status = .writtingDown
    }
  }
  
  func skipPressed() {
    completion?(view.viewController)
  }
  
  func clearPressed() {
    if currentPhrase.isEmpty {
      view.setBottomMnemonicView(hidden: true, animated: false)
      view.show(phrase: mnemonic, shuffled: mnemonic.shuffled())
      status = .writtingDown
    } else {
      removeLast()
      view.removeLastWord()
    }
  }
  
  func wordPressed(_ word: String) {
    
    add(word: word)
    view.add(word: word)
    
    if finished {
      view.setBottomMnemonicView(hidden: true, animated: true)
      status = correct ? .correct : .incorrect
      
      clearWords()
    }
  }
}


// MARK: - MnemonicInteractorOutput

extension MnemonicPresenter: MnemonicInteractorOutput {
  
  func didReceiveMnemonic(_ mnemonic: [String]) {
    self.mnemonic = mnemonic
    view.show(phrase: mnemonic, shuffled: mnemonic.shuffled())
  }
  
}


// MARK: - MnemonicModuleInput

extension MnemonicPresenter: MnemonicModuleInput {
  
  func present(from viewController: UIViewController, state: MnemonicState, completion: ((UIViewController) -> Void)?) {
    self.completion = completion
    self.mnemonicState = state
    view.present(fromViewController: viewController)
  }
  
  func presentModal(from viewController: UIViewController, state: MnemonicState, completion: ((UIViewController) -> Void)?) {
    self.completion = completion
    self.mnemonicState = state
    view.presentModal(fromViewController: viewController)
  }
}
