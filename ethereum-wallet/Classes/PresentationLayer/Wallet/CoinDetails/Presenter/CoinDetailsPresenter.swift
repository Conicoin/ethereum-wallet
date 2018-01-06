//
//  CoinDetailsCoinDetailsPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class CoinDetailsPresenter {
  
  weak var view: CoinDetailsViewInput!
  weak var output: CoinDetailsModuleOutput?
  var interactor: CoinDetailsInteractorInput!
  var router: CoinDetailsRouterInput!
  
  var coin: Coin!
}


// MARK: - CoinDetailsViewOutput

extension CoinDetailsPresenter: CoinDetailsViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveCoin(coin)
  }
  
  func didSendPressed() {
    router.presentSend(for: coin, from: view.viewController)
  }
  
  func didReceivePressed() {
    router.presentReceive(for: coin, from: view.viewController)
  }
  
}


// MARK: - CoinDetailsInteractorOutput

extension CoinDetailsPresenter: CoinDetailsInteractorOutput {
  
}


// MARK: - CoinDetailsModuleInput

extension CoinDetailsPresenter: CoinDetailsModuleInput {
  
  func present(with coin: Coin, from: UIViewController) {
    self.coin = coin
    view.present(fromViewController: from)
  }
  
}
