// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit
import SafariServices

class WelcomeViewController: UIViewController {

  var output: WelcomeViewOutput!
    
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
  @IBOutlet var newWalletButton: UIButton!
  @IBOutlet var importWalletButton: UIButton!


  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
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
  
  // MARK: Privates
  
  private func localize() {
    #if TESTNET
    titleLabel.text = Localized.welcomeTitleTestnet()
    #else
    titleLabel.text = Localized.welcomeTitle()
    #endif
    subtitleLabel.text = Localized.welcomeSubtitle()
    importWalletButton.setTitle(Localized.welcomeImportTitle(), for: .normal)
  }
  
  private func showActionSheet() {
    let sheet = UIAlertController(title: Localized.welcomeImportAlert(), message: nil, preferredStyle: .actionSheet)
    let jsonKey = UIAlertAction(title: Localized.welcomeImportJson(), style: .default) { [unowned self] _ in
      self.output.didImportJsonKeyPressed()
    }
    let privateKey = UIAlertAction(title: Localized.welcomeImportPrivate(), style: .default) { [unowned self] _ in
      self.output.didImportPrivateKeyPressed()
    }
    let mnemonic = UIAlertAction(title: Localized.welcomeImportMnemonic(), style: .default) { [unowned self] _ in
      self.output.didImportMnemonicPressed()
    }
    let cancel = UIAlertAction(title: Localized.commonCancel(), style: .cancel, handler: nil)
    sheet.addAction(jsonKey)
    sheet.addAction(privateKey)
    sheet.addAction(mnemonic)
    sheet.addAction(cancel)

    present(sheet, animated: true, completion: nil)
  }
  
  // MARK: Actions
  
  @IBAction func newWalletPressed(_ sender: UIButton) {
    output.newDidPressed()
  }
  
  @IBAction func importWalletPressed(_ sender: UIButton) {
    showActionSheet()
  }
  

}


// MARK: - WelcomeViewInput

extension WelcomeViewController: WelcomeViewInput {
    
  func setupInitialState(restoring: Bool) {
    let buttonTitle = restoring ?
      Localized.welcomeRestoreTitle() :
      Localized.welcomeNewTitle()
    newWalletButton.setTitle(buttonTitle, for: .normal)
    newWalletButton.layer.cornerRadius = 5
  }

}
