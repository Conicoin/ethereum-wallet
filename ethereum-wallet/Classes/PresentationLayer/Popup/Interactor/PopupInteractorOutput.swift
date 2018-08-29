// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


protocol PopupInteractorOutput: class {
  func postProcessDidSucced()
  func didFailed(with error: Error)
}
