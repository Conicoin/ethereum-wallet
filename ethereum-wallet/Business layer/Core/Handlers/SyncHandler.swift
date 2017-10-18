//
//  SyncHandler.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

struct SyncHandler {
    
    let didChangeProgress: (Int64, Int64) -> Void
    let didFinished: VoidBlock

}
