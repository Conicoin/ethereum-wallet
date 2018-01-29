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


class PasswordViewController: UIViewController {

  var output: PasswordViewOutput!
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var helperTextView: UITextView!
  
  // MARK: Life cycle

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textField.becomeFirstResponder()
    tableView.tableFooterView?.isHidden = true // removing until better times
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    output.viewIsAppear()
  }
  
  // MARK: Action
  
  @IBAction func closePressed(_ sender: UIBarButtonItem) {
    output.closeDidPressed()
  }

}

// MARK: - TableView

extension PasswordViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch indexPath.section {
    case 0:
      let cell = tableView.dequeue(ChainCell.self, for: indexPath)
      cell.selectionStyle = .none
      cell.textLabel?.text = output.chains[indexPath.row].localizedDescription
      return cell
      
    case 1:
      let cell = tableView.dequeue(ModeCell.self, for: indexPath)
      cell.titleLabel.text = Localized.modeTitle()
      cell.switcher.isOn = Bool(output.syncMode.rawValue)
      cell.delegate = self
      return cell
      
    default:
      return UITableViewCell()
    }
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1 // removing until better times
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return output.chains.count
    } else {
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard indexPath.section == 0 else { return }
    output.selectChain(at: indexPath.row)
  }
  
}

// MARK: - ModeCellDelegate

extension PasswordViewController: ModeCellDelegate {
  
  func modeDidChanged(_ value: Bool) {
    output.didChangeSyncMode(value)
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
    let indexPath = IndexPath(row: index, section: 0)
    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }
  
  func didChangedMode(_ mode: SyncMode) {
    helperTextView.text = mode.helperText
  }

}
