//
//  TxIndexDataStoreService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 26/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import RealmSwift

typealias Changes = (insertions: [TxIndex], modifications: [TxIndex], deletions: [TxIndex])

class TxIndexDataStoreService: RealmStorable<TxIndex>, TxIndexDataStoreServiceProtocol {
  
}
