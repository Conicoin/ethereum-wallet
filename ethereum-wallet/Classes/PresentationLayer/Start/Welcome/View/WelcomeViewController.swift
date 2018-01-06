// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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
  @IBOutlet weak var sourceButton: UIButton!
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
  
  // MARK: Privates
  
  private func localize() {
    titleLabel.text = Localized.welcomeTitle()
    subtitleLabel.text = Localized.welcomeSubtitle()
    importWalletButton.setTitle(Localized.welcomeImportTitle(), for: .normal)
    sourceButton.setTitle(Localized.welcomeGitgubLink(), for: .normal)
  }
  
  // MARK: Actions
  
  @IBAction func newWalletPressed(_ sender: UIButton) {
    output.newDidPressed()
  }
  
  @IBAction func importWalletPressed(_ sender: UIButton) {
    output.importDidPressed()
  }
  
  @IBAction func sourcePressed(_ sender: UIButton) {
    guard let url = URL(string: Constants.Common.githubUrl) else { return }
    let svc = SFSafariViewController(url: url)
    present(svc, animated: true, completion: nil)
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
