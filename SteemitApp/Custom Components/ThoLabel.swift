//
//  ThoLabel.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/5/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class ThoLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDefaults()
    }
    
    private func setupDefaults() {
        font = UIFont.init(name: "Kefa", size: 17)
        textColor = UIColor.barTintColor()
    }
}
