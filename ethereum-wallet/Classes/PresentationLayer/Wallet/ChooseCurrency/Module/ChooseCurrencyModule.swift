// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class ChooseCurrencyModule {
    
  class func create() -> ChooseCurrencyModuleInput {
    let router = ChooseCurrencyRouter()
    let presenter = ChooseCurrencyPresenter()
    let interactor = ChooseCurrencyInteractor()
    let viewController = R.storyboard.chooseCurrency.chooseCurrencyViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // MARK: - Injection
          
    return presenter
  }
    
}
