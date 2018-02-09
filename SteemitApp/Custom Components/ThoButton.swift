//
//  ThoButton.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/1/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

@IBDesignable class ThoButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    private func setupDefaults() {
        titleLabel?.font = UIFont.init(name: "Kefa", size: 17)
        setTitleColor(UIColor.barTintColor(), for: .normal)
    }
}
