//
//  NewHeadHandler.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 15/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import Geth

class NewHeadHandler: NSObject, GethNewHeadHandlerProtocol {
    
    let errorHandler: ((String) -> Void)?
    let newHeadHandler: ((GethHeader) -> Void)?
    
    init(errorHandler: ((String) -> Void)?, newHeadHandler: ((GethHeader) -> Void)?) {
        self.errorHandler = errorHandler
        self.newHeadHandler = newHeadHandler
        super.init()
    }
    
    func onError(_ failure: String!) {
        errorHandler?(failure)
    }
    
    func onNewHead(_ header: GethHeader!) {
        newHeadHandler?(header)
    }
    
}
