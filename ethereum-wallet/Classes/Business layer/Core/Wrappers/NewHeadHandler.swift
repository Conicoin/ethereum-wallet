// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
