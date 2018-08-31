// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import RealmSwift

class RealmTokenMeta: Object {
  @objc dynamic var address = ""
  @objc dynamic var name = ""
  @objc dynamic var symbol = ""
  @objc dynamic var decimals: Int = 0
}
