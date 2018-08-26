//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class MnemonicModule {
  
  class func create() -> MnemonicModuleInput {
    let router = MnemonicRouter()
    let presenter = MnemonicPresenter()
    let interactor = MnemonicInteractor()
    let viewController = R.storyboard.mnemonic.mnemonicViewController()!
    
    interactor.output = presenter
    
    viewController.output = presenter
    
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // Injection
    let keychain = Keychain()
    interactor.accountService = AccountService(keychain: keychain)
    interactor.keychain = keychain
    
    return presenter
  }
  
}
