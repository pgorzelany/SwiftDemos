//
//  SlideAnimator.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import Foundation
import UIKit


class SlideAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDuration = 0.5
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return self.animationDuration
        
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        
    }
    
}