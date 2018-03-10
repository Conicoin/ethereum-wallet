//
//  DefaultButton.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 10/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

enum FloatingButtonStyle: Int {
    case blue
}

@IBDesignable
class DefaultButton: UIButton {

    var buttonStyle: FloatingButtonStyle = FloatingButtonStyle.blue {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        setBackgroundImage(nil, for: .normal)
        setTitleColor(.white, for: .normal)
        clipsToBounds = false
        updateAppearance()
    }
    
    private func updateAppearance() {
        if !isEnabled {
            transform = .identity
            layer.shadowOpacity = 0.08
            layer.shadowRadius = 4
            layer.shadowOffset = CGSize(width: 0, height: 8)
        } else if isHighlighted {
            transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = 8
            layer.shadowOffset = CGSize(width: 0, height: 4)
        } else {
            transform = .identity
            layer.shadowOpacity = 0.2
            layer.shadowRadius = 16
            layer.shadowOffset = CGSize(width: 0, height: 8)
        }
        backgroundColor = getBackgroundColor()
        layer.shadowColor = getShadowColor()
    }
    
    private func getBackgroundColor() -> UIColor {
        switch buttonStyle {
        case .blue:
            return Theme.Color.blue
        }
    }
    
    fileprivate func getShadowColor() -> CGColor {
        switch buttonStyle {
        case .blue:
            return Theme.Color.blue.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) * 0.5
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 48)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted != oldValue {
                UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState,
                               animations: updateAppearance, completion: nil)
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled != oldValue {
                UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState,
                               animations: updateAppearance, completion: nil)
            }
        }
    }
    
    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        if ["shadowOpacity", "shadowRadius", "shadowOffset", "backgroundColor"].contains(event) {
            return CABasicAnimation()
        } else {
            return super.action(for: layer, forKey: event)
        }
    }
}
