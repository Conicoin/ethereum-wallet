// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import RealmSwift

class MigrationConfigurator: ConfiguratorProtocol {

  func configure() {
    Realm.Configuration.defaultConfiguration = Realm.Configuration(
      schemaVersion: 7,
      migrationBlock: { migration, oldSchemaVersion in

        if oldSchemaVersion == 6 {
          migration.deleteData(forType: RealmToken.className())
          migration.deleteData(forType: RealmCoin.className())
        }
    })
  }

}
