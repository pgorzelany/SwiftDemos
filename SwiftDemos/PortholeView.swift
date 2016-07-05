//
//  PortholeView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class PortholeView: UIView {
    
    @IBInspectable var innerCornerRadius: CGFloat = 10.0
    @IBInspectable var inset: CGFloat = 20.0
    @IBInspectable var fillColor: UIColor = UIColor.grayColor()
    @IBInspectable var strokeWidth: CGFloat = 5.0
    @IBInspectable var strokeColor: UIColor = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        // Prep constants
        let roundRectWidth = rect.width - (2 * inset)
        let roundRectHeight = rect.height - (2 * inset)
        
        // Use EvenOdd rule to subtract portalRect from outerFill
        // (See http://stackoverflow.com/questions/14141081/uiview-drawrect-draw-the-inverted-pixels-make-a-hole-a-window-negative-space)
        let outterFill = UIBezierPath(rect: rect)
        let portalRect = CGRectMake(
            rect.origin.x + inset,
            rect.origin.y + inset,
            roundRectWidth,
            roundRectHeight)
        fillColor.setFill()
        let portal = UIBezierPath(roundedRect: portalRect, cornerRadius: innerCornerRadius)
        outterFill.appendPath(portal)
        outterFill.usesEvenOddFillRule = true
        outterFill.fill()
        strokeColor.setStroke()
        portal.lineWidth = strokeWidth
        portal.stroke()
    }
}