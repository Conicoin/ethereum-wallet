//
//  PlainButton.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 10/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

@IBDesignable
class PlainButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setTitleColor(Theme.Color.blue, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }

}
