//
//  PasswordPasswordViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class PasswordViewController: UITableViewController {

  var output: PasswordViewOutput!

  @IBOutlet weak var textField: UITextField!

  // MARK: Life cycle

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    textField.becomeFirstResponder()
  }
  
  // MARK: Action
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

}

// MARK: - UITextFieldDelegate

extension PasswordViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text else { return true}
    output.didConfirmPassword(text)
    textField.resignFirstResponder()
    return true
  }
  
}


// MARK: - PasswordViewInput

extension PasswordViewController: PasswordViewInput {
    
  func setupInitialState(restoring: Bool) {
    textField.enablesReturnKeyAutomatically = true
    
    title = restoring ?
      R.string.localizable.restorePasswordTitle() :
      R.string.localizable.newPasswordTitle()
  }

}
