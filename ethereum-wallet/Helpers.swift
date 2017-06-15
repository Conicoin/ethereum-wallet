//
//  Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

typealias VoidBlock = () -> Void
typealias JSONDict = [String: Any]

func Global(_ block: @escaping VoidBlock) {
    DispatchQueue.global().async {
        block()
    }
}

func Main(_ block: @escaping VoidBlock) {
    DispatchQueue.main.async {
        block()
    }
}
