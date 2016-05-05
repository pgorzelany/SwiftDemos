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
    
    var presenting = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return self.animationDuration
        
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let detailView = self.presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(detailView)
        
        if presenting {
            
            detailView.center = containerView.center
            detailView.transform = CGAffineTransformMakeTranslation(containerView.frame.size.width, 0)
            UIView.animateWithDuration(self.animationDuration, animations: {
                
                detailView.transform = CGAffineTransformIdentity
                
            }) { (finished) in
                
                transitionContext.completeTransition(true)
                
            }
        } else {
            
            UIView.animateWithDuration(self.animationDuration, animations: { 
                
                detailView.transform = CGAffineTransformMakeTranslation(containerView.frame.size.width, 0)
                
            }, completion: { (finished) in
                
                transitionContext.completeTransition(true)
                
            })
        }
        
    }
    
}