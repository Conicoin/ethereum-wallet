// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


class PartnersPresenter {

  weak var view: PartnersViewInput!
  weak var output: PartnersModuleOutput?
  var interactor: PartnersInteractorInput!
  var router: PartnersRouterInput!

}


// MARK: - PartnersViewOutput

extension PartnersPresenter: PartnersViewOutput {

  func viewIsReady() {
    view.setupInitialState()
  }

}


// MARK: - PartnersInteractorOutput

extension PartnersPresenter: PartnersInteractorOutput {

}


// MARK: - PartnersModuleInput

extension PartnersPresenter: PartnersModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }
}
