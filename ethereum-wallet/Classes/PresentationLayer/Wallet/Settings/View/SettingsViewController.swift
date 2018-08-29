// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


class SettingsViewController: UIViewController {
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var currencyImageView: UIImageView!
  @IBOutlet var currencyIsoLabel: UILabel!
  @IBOutlet var currencyButton: UIButton!
  @IBOutlet var changePasscodeButton: UIButton!
  @IBOutlet var touchIdButton: UIButton!
  @IBOutlet var touchIdSwitch: UISwitch!
  @IBOutlet var pushButton: UIButton!
  @IBOutlet var pushSwitch: UISwitch!
  @IBOutlet var rateButton: UIButton!
  @IBOutlet var backupButton: UIButton!
  @IBOutlet var logoutButton: UIButton!
  @IBOutlet var versionLabel: UILabel!
  
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
    pushButton.setTitle(Localized.settingsPush(), for: .normal)
    rateButton.setTitle(Localized.settingsRate(), for: .normal)
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
  
  @IBAction func pushPressed(_ sender: UIButton) {
    let isOn = !pushSwitch.isOn
    pushSwitch.setOn(isOn, animated: true)
    output.didPushValueChanged(isOn)
  }
  
  @IBAction func backupPressed(_ sender: UIButton) {
    output.didBackupPressed()
  }
  
  @IBAction func touchIdValueChanged(_ sender: UISwitch) {
    output.didTouchIdValueChanged(sender.isOn)
  }
  
  @IBAction func pushValueChanged(_ sender: UISwitch) {
    output.didPushValueChanged(sender.isOn)
  }
  
  @IBAction func ratePressed(_ sender: UIButton) {
    output.didRateAppPressed()
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
  
  func setIsTouchIdEnabled(_ isTouchIdEnabled: Bool) {
    touchIdSwitch.isOn = isTouchIdEnabled
  }
  
  func setCurrency(_ currency: FiatCurrency) {
    currencyImageView.image = currency.icon
    currencyIsoLabel.text = currency.iso
  }
  
  func shareFileAtUrl(_ url: URL) {
    let objectsToShare = [url]
    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
    present(activityVC, animated: true, completion: nil)
  }
  
  func setPushSwitch(_ iOn: Bool) {
    pushSwitch.setOn(iOn, animated: true)
  }
  
}
