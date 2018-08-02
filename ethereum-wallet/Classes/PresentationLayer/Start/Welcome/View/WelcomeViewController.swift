// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import UIKit
import SafariServices

class WelcomeViewController: UIViewController {

  var output: WelcomeViewOutput!
    
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var newWalletButton: UIButton!
  @IBOutlet weak var importWalletButton: UIButton!


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
    titleLabel.text = Localized.welcomeTitle()
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
