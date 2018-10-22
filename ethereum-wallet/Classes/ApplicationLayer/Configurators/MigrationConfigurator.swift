// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import RealmSwift

class MigrationConfigurator: ConfiguratorProtocol {

  func configure() {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(
      schemaVersion: 8,
      migrationBlock: { migration, oldSchemaVersion in

        if oldSchemaVersion < 7 {
          migration.deleteData(forType: RealmToken.className())
          migration.deleteData(forType: RealmCoin.className())
        } else if oldSchemaVersion < 8 {
          migration.deleteData(forType: RealmTransaction.className())
        }
    })
  }

}
