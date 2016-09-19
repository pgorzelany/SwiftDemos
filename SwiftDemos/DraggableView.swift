//
//  DraggableView.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 19/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class DraggableView: UIView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let window = UIApplication.shared.keyWindow, let touch = touches.first {
            
            let target = touch.location(in: window)
            self.center = target
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let window = UIApplication.shared.keyWindow, let touch = touches.first {
            
            let target = touch.location(in: window)
            self.center = target
            
        }
        
    }

}
