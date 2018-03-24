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

enum ImportState {
  case jsonKey
  case privateKey
}

class ImportModule {
    
  class func create(with state: ImportState) -> ImportModuleInput {
    let router = ImportRouter()
    let presenter = ImportPresenter()
    let interactor = ImportInteractor()
    let viewController = R.storyboard.import.importViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // MARK: Injection
    
    let keystore = KeystoreService()
    let walletDataStore = WalletDataStoreService()
    
    interactor.verificator = ImportVerificatorFactory().create(state)
    interactor.walletImporter = WalletImporterFactory(keystoreService: keystore, walletDataStoreService: walletDataStore).create(state)
    presenter.state = ImportStateFactory(state: state).create()
        
    return presenter
  }
    
}
