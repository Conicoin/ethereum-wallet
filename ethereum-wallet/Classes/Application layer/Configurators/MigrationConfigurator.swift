//
//  MigrationConfigurator.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 03/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import RealmSwift

class MigrationConfigurator: ConfiguratorProtocol {

  func configure() {
    
    Realm.Configuration.defaultConfiguration = Realm.Configuration(
      schemaVersion: 2,
      migrationBlock: { migration, oldSchemaVersion in

        migration.deleteData(forType: RealmToken.className())
        
    })
  }

}
