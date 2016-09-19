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
    
    fileprivate let animationDuration = 0.5
    
    var presenting = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.animationDuration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let detailView = self.presenting ? toView : transitionContext.view(forKey: UITransitionContextViewKey.from)!
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: detailView)
        
        if presenting {
            
            detailView.center = containerView.center
            detailView.transform = CGAffineTransform(translationX: containerView.frame.size.width, y: 0)
            UIView.animate(withDuration: self.animationDuration, animations: {
                
                detailView.transform = CGAffineTransform.identity
                
            }, completion: { (finished) in
                
                transitionContext.completeTransition(true)
                
            }) 
        } else {
            
            UIView.animate(withDuration: self.animationDuration, animations: { 
                
                detailView.transform = CGAffineTransform(translationX: containerView.frame.size.width, y: 0)
                
            }, completion: { (finished) in
                
                transitionContext.completeTransition(true)
                
            })
        }
        
    }
    
}

extension SlideAnimator: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        self.presenting = false
        return self
    }
}
