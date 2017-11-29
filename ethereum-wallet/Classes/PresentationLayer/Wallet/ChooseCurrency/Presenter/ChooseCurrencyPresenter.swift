// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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


class ChooseCurrencyPresenter {
    
  weak var view: ChooseCurrencyViewInput!
  weak var output: ChooseCurrencyModuleOutput?
  var interactor: ChooseCurrencyInteractorInput!
  var router: ChooseCurrencyRouterInput!
  
  var currencies = Constants.Wallet.supportedCurrencies

}


// MARK: - ChooseCurrencyViewOutput

extension ChooseCurrencyPresenter: ChooseCurrencyViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
  }
  
  func didSelectCurrency(at index: Int) {
    output?.didSelectCurrency(currencies[index])
    view.dissmiss()
  }

}


// MARK: - ChooseCurrencyInteractorOutput

extension ChooseCurrencyPresenter: ChooseCurrencyInteractorOutput {
  
}


// MARK: - ChooseCurrencyModuleInput

extension ChooseCurrencyPresenter: ChooseCurrencyModuleInput {
  
  func present(from: UIViewController, output: ChooseCurrencyModuleOutput) {
    self.output = output
    view.present(fromViewController: from)
  }

}
