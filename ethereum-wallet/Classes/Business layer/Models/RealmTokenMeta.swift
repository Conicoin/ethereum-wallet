//
//  RealmTokenMeta.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import RealmSwift

class RealmTokenMeta: Object {
  @objc dynamic var address = ""
  @objc dynamic var name = ""
  @objc dynamic var symbol = ""
  @objc dynamic var decimals: Int64 = 0
}
