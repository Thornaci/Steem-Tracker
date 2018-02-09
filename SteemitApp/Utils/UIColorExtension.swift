//
//  UIColorExtension.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/21/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func barTintColor () -> UIColor {
        return UIColor.init(red: 37/255, green: 213/255, blue: 170/255, alpha: 1)
    }
    
    static func navBarBackgroundColor () -> UIColor {
        return UIColor.init(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
    }
    
    static func navBarBorderColor () -> UIColor {
        return UIColor.init(red: 49/255, green: 49/255, blue: 49/255, alpha: 1)
    }
    
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
