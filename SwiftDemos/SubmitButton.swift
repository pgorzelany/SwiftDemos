//
//  SubmitButton.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 04/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import Foundation

class SubmitButton: UIButton {
    
    enum State {
        case Normal, Active
    }
    
    // MARK: Properties
    
    var originalTitleColor: UIColor?
    
    var activityIndicator = UIActivityIndicatorView()
    var animationDuration = 0.5
    
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    // MARK: Methods
    
    func animateToState(state: State, completion: (() -> Void)?) {
        
        switch state {
        case .Active:
            
            self.originalTitleColor = self.currentTitleColor
            self.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
            
            CATransaction.begin()
            
            let animation = CABasicAnimation(keyPath: "bounds.size.width")
            animation.fromValue = self.bounds.size.width
            animation.toValue = self.bounds.size.height
            animation.duration = self.animationDuration
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            CATransaction.setCompletionBlock({ 
                
                self.activityIndicator.startAnimating()
                self.superview?.addSubview(self.activityIndicator, centerInView: self)
                completion?()
            })
            
            self.layer.addAnimation(animation, forKey: "shrink")
            
            CATransaction.commit()
            
        case .Normal:

            self.layer.removeAllAnimations()
            self.activityIndicator.removeFromSuperview()
            self.setTitleColor(self.originalTitleColor, forState: .Normal)
            completion?()
        }
        
        
    }

    func animateFillScreen(completion: (() -> Void)?) {

        let scale = (UIScreen.mainScreen().bounds.size.height / self.bounds.size.height) * 2
        
        CATransaction.begin()
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = scale
        animation.duration = self.animationDuration
        
        CATransaction.setCompletionBlock { 
            
            completion?()
        }
        
        self.layer.addAnimation(animation, forKey: "fill")
        
        CATransaction.commit()
    }
    
    func resetToInitialState() {
        
        self.animateToState(.Normal, completion: nil)
    }
}
