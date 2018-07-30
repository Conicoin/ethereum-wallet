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
  
  
  var output: SendViewOutput!
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    localize()
    setupTextFields()
    scrollView.setupBorder()
    recepientTextField.textField.addTarget(self, action: #selector(addressChanged(_:)), for: .editingChanged)
    output.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    amountTextField.becomeFirstResponder()
  }
  
  // MARK: Privates
    
  private func localize() {
    recepientTextField.placeholder = Localized.sendAddressPlaceholder()
    sendButton.setTitle(Localized.sendTitleEmpty(), for: .normal)
  }
  
  private func setupTextFields() {
    recepientTextField.textField.setRightPadding(30)
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
  
  @IBAction func advancedPressed(_ sender: UIBarButtonItem) {
    output.didAdvancedPressed()
  }
  
  @objc func addressChanged(_ sender: UITextField) {
    output.didChangeAddress(sender.text!)
  }
  
}

// MARK: - SendViewInput

extension SendViewController: SendViewInput {
  
  func setupInitialState() {
    inputDataIsValid(false)
  }
  
  func setCoin(_ coin: CoinDisplayable) {
    let title = Localized.sendTitle(coin.balance.name)
    navigationItem.title = title
    balanceLabel.text = coin.balance.amountString
    currencyLabel.text = coin.balance.symbol
  }
  
  func setAddressFromQR(_ address: String) {
    recepientTextField.textField.text = address
    recepientTextField.changeToFloat(animated: true)
  }
  
  func setLocalAmount(_ localAmount: String?) {
    localAmountLabel.text = localAmount
  }
  
  func setCheckout(amount: String, total: String, fee: String) {
    feeTitleLabel.text = Localized.sendFee()
    totalTitleLabel.text = Localized.sendTotal()
    totalLabel.text = total
    feeLabel.text = fee
    UIView.performWithoutAnimation {
      self.sendButton.setTitle(Localized.sendTitle(amount), for: .normal)
      self.sendButton.layoutIfNeeded()
    }
  }
  
  func setCurrency(_ currency: String) {
    UIView.performWithoutAnimation {
      self.currencyButton.setTitle(currency, for: .normal)
      self.currencyButton.layoutIfNeeded()
    }
  }
  
  func inputDataIsValid(_ isValid: Bool) {
    sendButton.isEnabled = isValid
  }

  func loadingFilure() {
    amountTextField?.becomeFirstResponder()
  }

}
