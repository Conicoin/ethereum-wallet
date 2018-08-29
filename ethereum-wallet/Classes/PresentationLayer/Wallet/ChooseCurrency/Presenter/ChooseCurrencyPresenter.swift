// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class ChooseCurrencyPresenter {
    
  weak var view: ChooseCurrencyViewInput!
  weak var output: ChooseCurrencyModuleOutput?
  var interactor: ChooseCurrencyInteractorInput!
  var router: ChooseCurrencyRouterInput!
  
  var selectedIso: String!
}


// MARK: - ChooseCurrencyViewOutput

extension ChooseCurrencyPresenter: ChooseCurrencyViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    view.selectCurrency(with: selectedIso)
  }
  
  func didSelectCurrency(_ currency: FiatCurrency) {
    output?.didSelectCurrency(currency)
    view.dissmiss()
  }

}


// MARK: - ChooseCurrencyInteractorOutput

extension ChooseCurrencyPresenter: ChooseCurrencyInteractorOutput {
  
}


// MARK: - ChooseCurrencyModuleInput

extension ChooseCurrencyPresenter: ChooseCurrencyModuleInput {
  
  func present(from: UIViewController, selectedIso: String, output: ChooseCurrencyModuleOutput) {
    self.output = output
    self.selectedIso = selectedIso
    view.present(fromViewController: from)
  }

}
