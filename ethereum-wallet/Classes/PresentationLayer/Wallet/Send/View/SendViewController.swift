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
import PKHUD


class SendViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var currencyLabel: UILabel!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var currencyButton: UIButton!
  @IBOutlet weak var localAmountLabel: UILabel!
  @IBOutlet weak var recepientTextField: DefaultTextField!
  @IBOutlet weak var scanQrButton: UIButton!
  @IBOutlet weak var feeTitleLabel: UILabel!
  @IBOutlet weak var totalTitleLabel: UILabel!
  @IBOutlet weak var feeLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!
  @IBOutlet weak var sendButtonConstraint: NSLayoutConstraint!
  
  
  var output: SendViewOutput!
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    setupTextFields()
    scrollView.setupBorder()
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupKeyboardNotifications()
    amountTextField.becomeFirstResponder()
  }
  
  // MARK: Privates
    
  private func localize() {
    feeTitleLabel.text = Localized.sendFee()
    totalTitleLabel.text = Localized.sendTotal()
    recepientTextField.placeholder = Localized.sendAddressPlaceholder()
  }
  
  private func setupTextFields() {
    recepientTextField.textField.delegate = self
    recepientTextField.textField.setRightPadding(30)

  }
  
  private func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillShow(notification: Notification) {
    let userInfo = notification.userInfo!
    let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
    keyboardConstraint.constant = keyboardFrame.size.height
    sendButtonConstraint.constant = keyboardFrame.size.height + 16
  }
  
  @objc func keyboardWillHide(notification: Notification){
    keyboardConstraint.constant = 0
    sendButtonConstraint.constant = 16
  }
  
  // MARK: Actions
  
  @IBAction func sendPressed(_ sender: UIButton) {
    output.didSendPressed()
  }
  
  @IBAction func currencyPressed(_ sender: UIButton) {
    output.didCurrencyPressed()
  }
  
  @IBAction func scanQRPressed(_ sender: UIButton) {
    output.didScanPressed()
  }
  
  @IBAction func amountDidChange(_ sender: UITextField) {
    output.didChangeAmount(sender.text!)
  }
  
}

// MARK: - UITextFieldDelegate

extension SendViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    output.didChangeAddress(textField.text!)
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }
  
}

// MARK: - SendViewInput

extension SendViewController: SendViewInput {
  
  func setupInitialState() {
    inputDataIsValid(false)
  }
  
  func didReceiveCoin(_ coin: CoinDisplayable) {
    let title = Localized.sendTitle(coin.balance.name)
    navigationItem.title = title
    balanceLabel.text = coin.balance.amountString
    currencyLabel.text = coin.balance.symbol
  }
  
  func didDetectQRCode(_ code: String) {
    recepientTextField.textField.text = code
  }
  
  func didReceiveCheckout(amount: String, fiatAmount: String, fee: String) {
    totalLabel.text = amount
    feeLabel.text = fee
    localAmountLabel.text = fiatAmount
  }
  
  func didReceiveCurrency(_ currency: String) {
    currencyButton.setTitle(currency, for: .normal)
  }
  
  func inputDataIsValid(_ isValid: Bool) {
    sendButton.isEnabled = isValid
  }
  
  func showLoading() {
    view.endEditing(true)
    Loading.show()
  }
  
  func loadingSuccess() {
    Loading.success()
  }
  
  func loadingFilure() {
    Loading.dismiss()
    amountTextField?.becomeFirstResponder()
  }

}
