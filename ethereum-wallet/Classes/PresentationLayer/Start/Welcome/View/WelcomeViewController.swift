//
//  WelcomeWelcomeViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 19/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {

  var output: WelcomeViewOutput!
    
  @IBOutlet weak var newWalletButton: UIButton!


  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
  
  // MARK: Actions
  
  @IBAction func enterWalletPressed() {
    output.presentPassword()
  }

}


// MARK: - WelcomeViewInput

extension WelcomeViewController: WelcomeViewInput {
    
  func setupInitialState(restoring: Bool) {
    let buttonTitle = restoring ?
      R.string.localizable.welcomeRestoreTitle() :
      R.string.localizable.welcomeNewTitle()
    newWalletButton.setTitle(buttonTitle, for: .normal)
    newWalletButton.layer.cornerRadius = 5
  }

}
