//
//  DraggableView.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 19/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class DraggableView: UIView {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if let window = UIApplication.sharedApplication().keyWindow, touch = touches.first {
            
            let target = touch.locationInView(window)
            self.center = target
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        
        if let window = UIApplication.sharedApplication().keyWindow, touch = touches.first {
            
            let target = touch.locationInView(window)
            self.center = target
            
        }
        
    }

}
