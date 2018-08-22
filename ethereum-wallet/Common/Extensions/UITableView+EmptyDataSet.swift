//
//  UITableView+EmptyDataSet.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

extension UITableView {

  func setEmptyView(with text: String) {
    emptyDataSetView() { view in
      let attributed = NSAttributedString(string: text, attributes: [
        NSAttributedStringKey.foregroundColor: Theme.Color.gray,
        NSAttributedStringKey.font: Theme.Font.regular16
        ])
      
      let offset = self.tableHeaderView?.bounds.height ?? 0
      view.titleLabelString(attributed).verticalOffset(offset/2).isScrollAllowed(true)
    }
  }
  
}
