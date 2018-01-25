// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import RealmSwift

enum CustomRealmError: Error {
  case parsingError
}

class RealmTransaction: Object {
  
  @objc dynamic var txHash = ""
  @objc dynamic var to = ""
  @objc dynamic var from = ""
  @objc dynamic var amount = ""
  @objc dynamic var timestamp = Date()
  @objc dynamic var isIncoming = false
  @objc dynamic var isPending = false
  
  override static func primaryKey() -> String? {
    return "txHash"
  }
  
}
