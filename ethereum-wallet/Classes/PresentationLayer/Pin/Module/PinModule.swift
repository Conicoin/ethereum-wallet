//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class PinModule {
    
  class func create(_ passcodeState: PasscodeState) -> PinModuleInput {
    let router = PinRouter()
    let presenter = PinPresenter()
    let interactor = PinInteractor()
    let viewController = R.storyboard.pin.pinViewController()!
    
    interactor.output = presenter
    viewController.output = presenter
    
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // MARK: Injection

    let passcodeService = PasscodeServiceFactory.create(with: passcodeState, delegate: presenter)
    interactor.passcodeService = passcodeService
    
    let postProcessFactory = PasscodePostProcessFactory(keychainService: KeystoreService(), walletDataStoreService: WalletDataStoreService())
    interactor.passcodePostProcess = postProcessFactory.create(with: passcodeState)
        
    return presenter
  }
    
}
