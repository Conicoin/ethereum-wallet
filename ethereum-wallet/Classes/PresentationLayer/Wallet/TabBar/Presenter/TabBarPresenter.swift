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


class TabBarPresenter {
  
  weak var view: TabBarViewInput!
  weak var output: TabBarModuleOutput?
  var interactor: TabBarInteractorInput!
  var router: TabBarRouterInput!
  
  private lazy var balanceModule: BalanceModuleInput = {
    let module = BalanceModule.create()
    module.output = self
    return module
  }()
  private lazy var transactionsModule: TransactionsModuleInput = TransactionsModule.create()
  private lazy var settingsModule: SettingsModuleInput = SettingsModule.create()
  
  private func insertViewControllers() {
    
    view.viewControllers = [
      balanceModule.viewController.wrapToNavigationController(),
      transactionsModule.viewController.wrapToNavigationController(),
      settingsModule.viewController.wrapToNavigationController()
    ]
    view.setTitles()
  }
  
}


// MARK: - TabBarViewOutput

extension TabBarPresenter: TabBarViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    insertViewControllers()
  }
}


// MARK: - TabBarInteractorOutput

extension TabBarPresenter: TabBarInteractorOutput {
  
  func syncDidUpdateBalance(_ balance: Decimal) {
    
  }
  
  func syncDidFailedWithError(_ error: Error) {
    DispatchQueue.main.async {
      error.showAllertIfNeeded(from: self.view.viewController)
    }
  }
  
  func syncDidChangeProgress(current: Int64, total: Int64) {
    balanceModule.syncDidChangeProgress(current: current, total: total)
  }
  
  func syncDidFinished() {
    balanceModule.syncDidFinished()
  }
  
}


// MARK: - TabBarModuleInput

extension TabBarPresenter: TabBarModuleInput {
  
  func present() {
    view.present()
  }
  
}


// MARK: - BalanceModuleOutput

extension TabBarPresenter: BalanceModuleOutput {
  
  func balanceViewIsReady() {
    interactor.startSynchronization()
  }
  
}
