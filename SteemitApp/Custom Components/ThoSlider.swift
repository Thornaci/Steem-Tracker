//
//  ThoSlider.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/18/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

@IBDesignable class ThoSlider: UIView {
    
    @IBInspectable var progress: CGFloat = 0.5
    @IBInspectable var borderColor: UIColor = UIColor.navBarBorderColor()
    @IBInspectable var fillColor: UIColor = UIColor.barTintColor()
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }
    
    private func setupDefaults() {
        let fillColorView = UIView.init(frame: CGRect.init(x: 5, y: 3, width: (self.frame.width - 10) * progress, height: self.frame.height - 6))
        fillColorView.tag = 101
        fillColorView.backgroundColor = fillColor
        fillColorView.layer.cornerRadius = cornerRadius
        self.insertSubview(fillColorView, at: 0)
    }
    
    func updateBar(_ progressPercent: CGFloat) {
        let fillColorView = self.viewWithTag(101)
        fillColorView?.frame.size = CGSize.init(width: (self.frame.width - 10) * progressPercent, height: self.frame.height - 6)
    }
}
