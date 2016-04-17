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
    
}
