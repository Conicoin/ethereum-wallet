// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


class SendSettingsPresenter {
    
  weak var view: SendSettingsViewInput!
  weak var output: SendSettingsModuleOutput?
  var interactor: SendSettingsInteractorInput!
  var router: SendSettingsRouterInput!
  
  private var settings: SendSettings!
  private var coin: AbstractCoin!
  private var localCurrency: String!
    
  private func calculateFee() {
    let amount = Ether(weiValue: settings.gasLimit * settings.gasPrice)
    let fiatString = coin.fiatString(amount: amount, iso: localCurrency)
    view.setFeeAmount(amount.amountString, fiatAmount: fiatString)
  }
    
}


// MARK: - SendSettingsViewOutput

extension SendSettingsPresenter: SendSettingsViewOutput {

  func viewIsReady() {
    view.setupInitialState(settings: settings, isToken: coin.isToken)
    interactor.getWallet()
  }
  
  func gasPriceDidChanged(_ gasPrice: Int) {
    settings.gasPrice = Decimal(gasPrice)
    calculateFee()
  }
  
  func gasLimitDidChanged(_ gasLimit: Int) {
    settings.gasLimit = Decimal(gasLimit)
    calculateFee()
  }
  
  func txDataDidChanged(_ txData: Data) {
    settings.txData = txData
  }
  
  func saveDidPressed() {
    output?.didSelect(settings: settings)
    view.dissmiss()
  }

}


// MARK: - SendSettingsInteractorOutput

extension SendSettingsPresenter: SendSettingsInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    self.localCurrency = wallet.localCurrency
    calculateFee()
  }

}


// MARK: - SendSettingsModuleInput

extension SendSettingsPresenter: SendSettingsModuleInput {
  
  func present(from viewController: UIViewController, settings: SendSettings, coin: AbstractCoin, output: SendSettingsModuleOutput?) {
    self.settings = settings
    self.output = output
    self.coin = coin
    view.present(fromViewController: viewController)
  }

}
