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
    https://github.com/flypaper0/ethereum-wallet
    """
    
    creditsTextView.delegate = self
    creditsTextView.text = credits
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCurrencyCell", for: indexPath)
    cell.textLabel?.text = output.currencies[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard indexPath.section == 0 else { return }
    output.didSelectCurrency(at: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return output.currencies.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return Localized.settingsCurrencyTitle()
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

}
