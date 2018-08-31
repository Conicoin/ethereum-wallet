// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import RealmSwift

class MigrationConfigurator: ConfiguratorProtocol {

  func configure() {
    
    Realm.Configuration.defaultConfiguration = Realm.Configuration(
      schemaVersion: 6,
      migrationBlock: { migration, oldSchemaVersion in

        migration.deleteData(forType: RealmToken.className())
        
    })
  }

}
