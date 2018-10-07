// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit
import EmptyDataSet_Swift

extension UITableView {

  func setEmptyView(with text: String) {
    emptyDataSetView() { view in
      let attributed = NSAttributedString(string: text, attributes: [
        NSAttributedString.Key.foregroundColor: Theme.Color.gray,
        NSAttributedString.Key.font: Theme.Font.regular16
        ])
      
      let offset = self.tableHeaderView?.bounds.height ?? 0
      view
        .titleLabelString(attributed)
        .verticalOffset(offset/2)
        .isScrollAllowed(true)
        .dataSetBackgroundColor(.white)
    }
  }
  
}
