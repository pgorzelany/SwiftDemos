//
//  PortholeView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class PortholeView: UIView {
    
    var _backgroundColor : UIColor?
    override var backgroundColor : UIColor? {
        get {return _backgroundColor}
        set {_backgroundColor = newValue}
    }
    
    var holeOrigin: CGPoint = CGPoint(x: 0,y: 0) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
//        super.drawRect(rect)
        
        self._backgroundColor?.setFill()
        UIRectFill(rect)
        
        
        let portholeRect = CGRect(x: holeOrigin.x, y: holeOrigin.y, width: 100, height: 100)
        let intersection = CGRectIntersection(portholeRect, rect)
        
        UIColor.clearColor().setFill()
        
        UIRectFill(intersection)
    }
}