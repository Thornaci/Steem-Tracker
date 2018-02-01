//
//  ThoButton.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/1/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

@IBDesignable class ThoButton : UIButton {
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
}
