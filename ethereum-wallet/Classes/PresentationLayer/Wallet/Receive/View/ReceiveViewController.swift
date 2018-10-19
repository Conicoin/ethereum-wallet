// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class ReceiveViewController: UIViewController {
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var qrImageView: UIImageView!
  @IBOutlet var copyAddressButton: UIButton!
  @IBOutlet var addressTitleLabel: UILabel!
  
  var output: ReceiveViewOutput!


  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    localize()
  }
  
  // MARK: Privates
  
  private func localize() {
    addressTitleLabel.text = Localized.receiveAddressTitle()
    copyAddressButton.setTitle(Localized.receiveCopyButton(), for: .normal)
  }
  
  // MARK: Actions
  
  @IBAction func copyAddressPressed() {
    guard let address = addressLabel.text else { return }
    output.copyAddressPressed(address: address)
  }
  
  @IBAction func sharePressed(_ sender: UIBarButtonItem) {
    let text = addressLabel.text!
    let image = qrImageView.image!
    let activity = UIActivityViewController(activityItems: [image, text], applicationActivities: nil)
    activity.excludedActivityTypes = [
      .airDrop,
      .copyToPasteboard,
      .message,
      .mail,
      .postToFacebook,
      .postToTwitter,
      .postToFlickr,
      .markupAsPDF,
    ]
    present(activity, animated: true, completion: nil)
  }

}


// MARK: - ReceiveViewInput

extension ReceiveViewController: ReceiveViewInput {
  
  func didReceiveCoin(_ coin: AbstractCoin) {
    let title = Localized.receiveTitle(coin.currency.name)
    navigationItem.title = title
  }
  
  func didReceiveWallet(_ wallet: Wallet) {
    addressLabel.text = wallet.address
  }
  
  func didReceiveQRImage(_ image: UIImage) {
    qrImageView.image = image
  }
    
  func setupInitialState() {

  }

}
