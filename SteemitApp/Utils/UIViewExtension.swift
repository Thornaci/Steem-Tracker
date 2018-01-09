//
//  UIViewExtension.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/9/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil, startPoint: nil, endPoint: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?, startPoint: CGPoint?, endPoint: CGPoint?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        if startPoint != nil && endPoint != nil {
            gradient.startPoint = startPoint!
            gradient.endPoint = endPoint!
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
