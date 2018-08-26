//
//  Collection+Extension.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 03/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

extension MutableCollection {
    
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

