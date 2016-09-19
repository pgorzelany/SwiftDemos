//
//  UIView+Extensions.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 17/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviewFullscreen(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": subview]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": subview]))
        
    }
    
    func addSubview(_ subview: UIView, centerInView: UIView) {
        
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: centerInView, attribute: .centerX, relatedBy: .equal, toItem: subview, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: centerInView, attribute: .centerY, relatedBy: .equal, toItem: subview, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    func setRoundedCorners() {
        
        self.clipsToBounds = true
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
    }
    
    /** Makes a transparent hole in the view */
    func cutTransparentHoleWithRect(_ rect: CGRect) {
        
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: self.bounds)
        path.append(UIBezierPath(rect: rect))
        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.fillRule = kCAFillRuleEvenOdd
        self.layer.mask = maskLayer
    }
    
}
