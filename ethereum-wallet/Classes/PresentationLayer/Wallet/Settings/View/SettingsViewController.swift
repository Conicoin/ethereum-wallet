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


class SettingsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var creditsTextView: UITextView!
  
  var output: SettingsViewOutput!
  
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCredits()
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  private func setupCredits() {
    let credits = """
    \(Bundle.main.displayName)
    \(Bundle.main.versionAndBuild)
    
    Source code:
    \(Constants.Common.githubUrl)
    """
    
    creditsTextView.delegate = self
    creditsTextView.text = credits
  }
  
  private func showBackupAlert() {
    let alert = UIAlertController(title: Localized.settingsBackupAlertTitle(), message: Localized.settingsBackupAlertMessage(), preferredStyle: .alert)
    alert.addTextField { textField in
      textField.placeholder = Localized.settingsBackupAlertPassword()
      textField.isSecureTextEntry = true
    }
    let backup = UIAlertAction(title: Localized.settingsBackupAlertOk(), style: .default) { action in
      guard let password = alert.textFields?.first?.text else {
        return
      }
      self.output.didEnterPasswordForBackup(password)
    }
    let cancel = UIAlertAction(title: Localized.settingsBackupAlertCancel(), style: .default, handler: nil)
    alert.addAction(backup)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
  }
  
  private func showExitAlert() {
    let alert = UIAlertController(title: Localized.settingsExitTitle(), message: Localized.settingsExitAlerMessage(), preferredStyle: .alert)
    alert.addTextField { textField in
      textField.placeholder = Localized.settingsExitPlaceholder()
      textField.isSecureTextEntry = true
    }
    let exit = UIAlertAction(title: Localized.settingsExitConfirm(), style: .destructive) { action in
      guard let password = alert.textFields?.first?.text else {
        return
      }
      self.output.didExitWalletPressed(passphrase: password)
    }
    let cancel = UIAlertAction(title: Localized.settingsExitCancel(), style: .default, handler: nil)
    alert.addAction(exit)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
  }
  
}

// MARK: - UITextViewDelegate

extension SettingsViewController: UITextViewDelegate {
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
    return true
  }
  
}

// MARK: - TableView

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeue(SettingsCurrencyCell.self, for: indexPath)
      cell.textLabel?.text = output.currencies[indexPath.row]
      return cell
    case 1:
      let cell = tableView.dequeue(SettingsBackupCell.self, for: indexPath)
      cell.textLabel?.text = Localized.settingsBackupTitle()
      return cell
    default:
      let cell = tableView.dequeue(SettingsExitCell.self, for: indexPath)
      cell.textLabel?.text = Localized.settingsExitTitle()
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      output.didSelectCurrency(at: indexPath.row)
    case 1:
      tableView.deselectRow(at: indexPath, animated: true) // TODO: Currency deselecting bug
      showBackupAlert()
    default:
      tableView.deselectRow(at: indexPath, animated: true)
      showExitAlert()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count = [output.currencies.count, 1, 1]
    return count[section]
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let headers = [Localized.settingsCurrencyHeader(), Localized.settingsBackupHeader(), ""]
    return headers[section]
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
}


// MARK: - SettingsViewInput

extension SettingsViewController: SettingsViewInput {
  
  func setupInitialState() {
    
  }
  
  func selectCurrency(at index: Int) {
    let indexPath = IndexPath(row: index, section: 0)
    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }
  
  func didStoreKey(at url: URL) {
    let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    activityViewController.completionWithItemsHandler = { _, _, _, _ in
      self.output.didShareBackup(at: url)
    }
    present(activityViewController, animated: true, completion: nil)
  }
  
}
