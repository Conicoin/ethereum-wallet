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
    
    var addedSections = IndexSet()
    var addedIndexes = [IndexPath]()
    var updatedIndexes = [IndexPath]()
    
    var isEmpty: Bool {
        return sections.count == 0
    }
    
    var hasChanges: Bool {
        return !addedIndexes.isEmpty || !addedSections.isEmpty || !updatedIndexes.isEmpty
    }
    
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


// MARK: - Diff

extension TransactionsDisplayerContainer {
    
    func transaction(for hash: String) -> TransactionDisplayer? {
        for section in sections {
            if let tx = section.transaction(for: hash) {
                return tx
            }
        }
        return nil
    }
    
    func fillDiff(with other: TransactionsDisplayerContainer?) {
        guard let other = other else {
            addedSections.insert(integersIn: 0 ..< sections.count)
            return
        }
        
        if sections.count > other.sections.count {
            addedSections.insert(integersIn: 0 ..< sections.count - other.sections.count)
        }
        
        for (i, section) in sections.enumerated() {
            for (j, tx) in section.transactions.enumerated() {
                let indexPath = IndexPath(row: j, section: i)
                if let existed = other.transaction(for: tx.tx.txHash) {
                    if existed != tx {
                        updatedIndexes.append(indexPath)
                    }
                } else {
                    addedIndexes.append(indexPath)
                }
            }
        }
    }
}
