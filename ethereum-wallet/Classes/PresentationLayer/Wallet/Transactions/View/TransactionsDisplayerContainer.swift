//
//  TransactionsContainer.swift
//  ethereum-wallet
//
//  Created by Nikita Medvedev on 15/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class TransactionsDisplayerContainer {

    var sections = [TransactionDisplayerSection]()
    
    func append(_ displayer: TransactionDisplayer, for time: Date) {
        let section = self.section(for: time)
        section.append(displayer)
    }

    func section(for date: Date) -> TransactionDisplayerSection {
        var section = sections.first(where: { $0.date == date })
        if section == nil {
            section = TransactionDisplayerSection(with: date)
            sections.append(section!)
            sections.sort { $0.date > $1.date }
        }
        return section!
    }
}
