//
//  ImportImportViewOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol ImportViewOutput: class {
  func viewIsReady()
  func closeDidPressed()
  func didConfirmJsonKey(_ jsonKey: String)
}
