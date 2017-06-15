//
//  GameService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 27/04/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
//import SocketIO

protocol GameServiceDelegate: class {
    
}

struct GameService {

    var delegate: GameServiceDelegate
    
    init(delegate: GameServiceDelegate) {
        self.delegate = delegate
    }
    
    func startGame() {
    }

}
