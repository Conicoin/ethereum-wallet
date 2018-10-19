// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


class SendSettingsViewController: UIViewController {
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var gasPriceTitleLabel: UILabel!
  @IBOutlet var gasPriceLabel: UILabel!
  @IBOutlet var gasPriceInfoLabel: UILabel!
  @IBOutlet var gasPriceSlider: UISlider!
  @IBOutlet var gasLimitTitleLabel: UILabel!
  @IBOutlet var gasLimitLabel: UILabel!
  @IBOutlet var gasLimitInfoLabel: UILabel!
  @IBOutlet var gasLimitSlider: UISlider!
  @IBOutlet var txDataLabel: UILabel!
  @IBOutlet var txDataTextView: UITextView!
  @IBOutlet var feeTitleLabel: UILabel!
  @IBOutlet var feeLabel: UILabel!
  @IBOutlet var txDataView: UIView!
  @IBOutlet var saveButton: UIBarButtonItem!
  
  private var border = BorderView()
  var output: SendSettingsViewOutput!
  
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    customize()
    localize()
    setupKeyboardNotifications()
    output.viewIsReady()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: Privates
  
  private func localize() {
    navigationItem.title = Localized.sendAdvTitle()
    gasPriceTitleLabel.text = Localized.sendAdvGasPrice()
    gasPriceInfoLabel.text = Localized.sendAdvGasPriceInfo()
    gasLimitTitleLabel.text = Localized.sendAdvGasLimit()
    gasLimitInfoLabel.text = Localized.sendAdvGasLimitInfo()
    txDataLabel.text = Localized.sendAdvTxData()
    feeTitleLabel.text = Localized.sendAdvNetworkFee()
    saveButton.title = Localized.sendAdvSave()
  }
  
  private func customize() {
    let thumb = UIImage(named: "Thumb")
    gasLimitSlider.setThumbImage(thumb, for: .normal)
    gasPriceSlider.setThumbImage(thumb, for: .normal)
    border.attach(to: scrollView)
    txDataTextView.delegate = self
  }
  
  private func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  // MARK: Action
  
  @IBAction func gasPriceChanged(_ slider: UISlider) {
    saveButton.isEnabled = true
    let value = Int(slider.value)
    gasPriceLabel.text = "\(value)"
    output.gasPriceDidChanged(value * Int(1e9))
  }
  
  @IBAction func gasLimitChanged(_ slider: UISlider) {
    saveButton.isEnabled = true
    let value = Int(slider.value)
    gasLimitLabel.text = "\(value)"
    output.gasLimitDidChanged(value)
  }
  
  @IBAction func saveDidPressed(_ sender: UIBarButtonItem) {
    output.saveDidPressed()
  }
  
  @objc func keyboardWillShow(notification: Notification) {
    let userInfo = notification.userInfo!
    let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let height = keyboardFrame.size.height
    scrollView.contentInset.bottom = keyboardFrame.size.height
    scrollView.contentOffset.y = max(height, scrollView.contentOffset.y)
  }
  
  @objc func keyboardWillHide(notification: Notification){
    scrollView.contentInset.bottom = 0
  }
  
}


// MARK: - SendSettingsViewInput

extension SendSettingsViewController: SendSettingsViewInput {
  
  func setupInitialState(settings: SendSettings, isToken: Bool) {
    gasPriceSlider.minimumValue = Constants.Send.minGasPrice.float / 1e9
    gasPriceSlider.maximumValue = Constants.Send.maxGasPrice.float / 1e9
    gasPriceSlider.setValue(settings.gasPrice.float / 1e9, animated: false)
    
    gasLimitSlider.minimumValue = Constants.Send.minGasLimit.float
    gasLimitSlider.maximumValue = Constants.Send.maxGasLimit.float
    gasLimitSlider.setValue(settings.gasLimit.float, animated: false)
    
    gasPriceLabel.text = (settings.gasPrice / 1e9).string
    gasLimitLabel.text = settings.gasLimit.string
    txDataView.isHidden = isToken
    
    txDataTextView.text = settings.txData?.hex() ?? "0x"
    
    saveButton.isEnabled = false
  }
  
  func setFeeAmount(_ amount: String, fiatAmount: String?) {
    var feeAmount = amount
    if let fiatAmount = fiatAmount {
      feeAmount += " (\(fiatAmount))"
    }
    feeLabel.text = feeAmount
  }
  
}


// MARK: UITextViewDelegate

extension SendSettingsViewController: UITextViewDelegate {
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
  
  func textViewDidChange(_ textView: UITextView) {
    let data = Data(hex: textView.text)
    if data.count > 0 {
      saveButton.isEnabled = true
      output.txDataDidChanged(data)
    }
  }
  
}
