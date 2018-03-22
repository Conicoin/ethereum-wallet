//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class PinModule {
    
  class func create(_ pinState: PinState) -> PinModuleInput {
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

    let pinService = PinServiceFactory.create(with: pinState, delegate: presenter)
    interactor.pinService = pinService

    return presenter
  }
    
}
