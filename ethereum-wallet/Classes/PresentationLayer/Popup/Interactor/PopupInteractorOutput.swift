//
//  PopupPopupInteractorOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol PopupInteractorOutput: class {
  func postProcessDidSucced()
  func didFailed(with error: Error)
}
