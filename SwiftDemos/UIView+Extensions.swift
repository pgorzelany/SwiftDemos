//
//  UIView+Extensions.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 17/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviewFullscreen(subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": subview]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": subview]))
        
    }
    
    func addSubview(subview: UIView, centerInView: UIView) {
        
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: centerInView, attribute: .CenterX, relatedBy: .Equal, toItem: subview, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: centerInView, attribute: .CenterY, relatedBy: .Equal, toItem: subview, attribute: .CenterY, multiplier: 1, constant: 0))
        
    }
    
    func setRoundedCorners() {
        
        self.clipsToBounds = true
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
    }
    
    /** Makes a transparent hole in the view */
    func cutTransparentHoleWithRect(rect: CGRect) {
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: self.bounds)
        path.appendPath(UIBezierPath(rect: rect))
        maskLayer.path = path.CGPath
        maskLayer.fillColor = UIColor.blackColor().CGColor
        maskLayer.fillRule = kCAFillRuleEvenOdd
        self.layer.mask = maskLayer
    }
    
}
