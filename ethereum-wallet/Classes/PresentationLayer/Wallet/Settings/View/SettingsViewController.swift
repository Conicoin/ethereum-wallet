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
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var currencyImageView: UIImageView!
  @IBOutlet weak var currencyIsoLabel: UILabel!
  @IBOutlet weak var currencyButton: UIButton!
  @IBOutlet weak var changePasscodeButton: UIButton!
  @IBOutlet weak var touchIdButton: UIButton!
  @IBOutlet weak var touchIdSwitch: UISwitch!
  @IBOutlet weak var backupButton: UIButton!
  @IBOutlet weak var logoutButton: UIButton!
  @IBOutlet weak var versionLabel: UILabel!
  
  var output: SettingsViewOutput!
  
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = Localized.settingsTitle()
    scrollView.setupBorder()
    localize()
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  private func localize() {
    currencyButton.setTitle(Localized.settingsCurrency(), for: .normal)
    changePasscodeButton.setTitle(Localized.settingsChangePasscode(), for: .normal)
    touchIdButton.setTitle(Localized.settingsTouchId(), for: .normal)
    backupButton.setTitle(Localized.settingsBackup(), for: .normal)
    logoutButton.setTitle(Localized.settingsLogout(), for: .normal)
    versionLabel.text = Localized.settingsVersion(Bundle.main.version)
  }
  
  // MARK: Actions
  
  @IBAction func currencyPressed(_ sender: UIButton) {
    output.didCurrencyPressed()
  }
  
  @IBAction func changePasscodePressed(_ sender: UIButton) {
    showAlert(title: Localized.settingsChangeAlertTitle(),
              message: Localized.settingsChangeAlertMsg(),
              cancelable: true) { _ in
      self.output.didChangePasscodePressed()
    }
  }
  
  @IBAction func touchIdPressed(_ sender: UIButton) {
    let isOn = !touchIdSwitch.isOn
    touchIdSwitch.setOn(isOn, animated: true)
    output.didTouchIdValueChanged(isOn)
  }
  
  @IBAction func backupPressed(_ sender: UIButton) {
    output.didBackupPressed()
  }
  
  @IBAction func touchIdValueChanged(_ sender: UISwitch) {
    output.didTouchIdValueChanged(sender.isOn)
  }
  
  @IBAction func logoutPressed(_ sender: UIButton) {
    showAlert(title: Localized.settingsExitAlertTitle(),
              message: Localized.settingsExitAlertMsg(),
              cancelable: true) { _ in
      self.output.didLogoutPressed()
    }
  }
}

// MARK: - SettingsViewInput

extension SettingsViewController: SettingsViewInput {
  
  func setupInitialState() {
    
  }
  
  func didReceiveIsTouchIdEnabled(_ isTouchIdEnabled: Bool) {
    touchIdSwitch.isOn = isTouchIdEnabled
  }
  
  func didReceiveCurrency(_ currency: FiatCurrency) {
    currencyImageView.image = currency.icon
    currencyIsoLabel.text = currency.iso
  }
  
  func shareFileAtUrl(_ url: URL) {
    let objectsToShare = [url]
    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
    present(activityVC, animated: true, completion: nil)
  }
  
}
