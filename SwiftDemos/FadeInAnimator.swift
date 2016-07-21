//
//  FadeInAnimator.swift
//  SwiftDemos
//
//  Created by Takuya Okamoto, Piotr Gorzelany on 21/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

public class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionDuration: NSTimeInterval = 0.2
    var startingAlpha: CGFloat = 0.0
    
    public convenience init(transitionDuration: NSTimeInterval, startingAlpha: CGFloat){
        self.init()
        self.transitionDuration = transitionDuration
        self.startingAlpha = startingAlpha
    }
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        toView.alpha = startingAlpha
        fromView.alpha = 0.8
        
        containerView!.addSubview(toView)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            
            toView.alpha = 1.0
            fromView.alpha = 0.0
            
            }, completion: {
                _ in
                fromView.alpha = 1.0
                transitionContext.completeTransition(true)
        })
    }
}

extension FadeInAnimator: UIViewControllerTransitioningDelegate {
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }
}
