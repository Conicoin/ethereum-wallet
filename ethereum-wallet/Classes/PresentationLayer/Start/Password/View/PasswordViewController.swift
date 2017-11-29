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


class PasswordViewController: UITableViewController {

  var output: PasswordViewOutput!
  
  @IBOutlet weak var textField: UITextField!

  // MARK: Life cycle

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textField.becomeFirstResponder()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    output.viewIsAppear()
  }
  
  // MARK: Action

}

// MARK: - TableView

extension PasswordViewController {
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard indexPath.section == 1 else {
      return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    let cell = ChainCell(style: .default, reuseIdentifier: "ChainCell")
    cell.selectionStyle = .none
    cell.textLabel?.text = output.chains[indexPath.row].localizedDescription
    
    return cell
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : output.chains.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard indexPath.section == 1 else { return }
    output.selectChain(at: indexPath.row)
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
      Localized.restorePasswordTitle() :
      Localized.newPasswordTitle()
  }
  
  func selectChain(at index: Int) {
    let indexPath = IndexPath(row: index, section: 1)
    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }

}
