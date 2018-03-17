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


class ImportViewController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var inputTextView: DefaultTextField!
  @IBOutlet weak var icloudButton: UIButton!
  @IBOutlet weak var confirmButton: UIButton!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
  var output: ImportViewOutput!

  private var shadowImage: UIImage?

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    inputTextView.textField.delegate = self
    setupKeyboardNotifications()
    localize()
    output.viewIsReady()
  }
  
  // MARK: Privates
  
  private func localize() {
    titleLabel.text = Localized.importTitle()
    icloudButton.setTitle(Localized.importIcloudTitle(), for: .normal)
    confirmButton.setTitle(Localized.importConfirmTitle(), for: .normal)
  }
  
  private func setupKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillShow(notification: Notification){
    let userInfo = notification.userInfo!
    let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    bottomConstraint.constant = keyboardFrame.size.height + 16
    view.layoutIfNeeded()
  }
  
  @objc func keyboardWillHide(notification: Notification){
    bottomConstraint.constant = 16
    view.layoutIfNeeded()
  }

  // MARK: Action
  
  @IBAction func icloudPressed(_ sender: UIButton) {
    let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.text"], in: .import)
    documentPicker.delegate = self
    present(documentPicker, animated: true, completion: nil)
  }
  
  @IBAction func confirmPressed(_ sender: UIButton) {
    output.didConfirmKey(inputTextView.textField.text!)
  }
  
}


// MARK: - ImportViewInput

extension ImportViewController: ImportViewInput {
    
  func setupInitialState() {

  }
  
  func didReceiveState(_ state: ImportStateProtocol) {
    inputTextView.placeholder = state.placeholder
    icloudButton.isHidden = !state.iCloudImportEnabled
  }

}


// MARK: - UITextFieldDelegate

extension ImportViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    confirmButton.isEnabled = string != ""
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    confirmPressed(confirmButton)
    return true
  }
  
}


// MARK: UIDocumentPickerDelegate

extension ImportViewController: UIDocumentPickerDelegate {
  
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    if let url = urls.first, let text = try? String(contentsOfFile: url.path) {
      output.didConfirmKey(text)
    }
  }
  
}
