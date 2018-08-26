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


class SendModule {
    
  class func create(_ type: TransferType) -> SendModuleInput {
    let router = SendRouter()
    let presenter = SendPresenter()
    let interactor = SendInteractor()
    let viewController: SendViewController = ScreenManager.instantiate(R.storyboard.send)
    
    interactor.output = presenter
    
    viewController.output = presenter
    
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // MARK: - Injection
    
    let core = Ethereum.core
    let keystore = KeystoreService()
    
    interactor.gasService = GasServiceFactory(core: core).create(type)
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.transactionsDataStoreService = TransactionsDataStoreService()
    interactor.transactionService = TransactionService(core: core, keystore: keystore, transferType: type)
    interactor.checkoutService = SendCheckoutServiceFactory().create(type)
    
    viewController.amountFormatter = AmountFormatter(decimals: type.decimals)
        
    return presenter
  }
    
}
