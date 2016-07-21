//
//  SubmitButton.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 04/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class SubmitButton: UIButton {
    
    enum State {
        case Normal, Active
    }
    
    // MARK: Properties
    
    var originalTitleColor: UIColor?
    
    var activityIndicator = UIActivityIndicatorView()
    var animationDuration = 0.5
    
    lazy var shrinkAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "bounds.size.width")
        animation.fromValue = self.bounds.size.width
        animation.toValue = self.bounds.size.height
        animation.duration = self.animationDuration
        return animation
    }()
    
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
            
            self.shrinkAnimation.fillMode = kCAFillModeForwards
            self.shrinkAnimation.removedOnCompletion = false
            self.shrinkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            
            CATransaction.setCompletionBlock({ 
                
                self.activityIndicator.startAnimating()
                self.superview?.addSubview(self.activityIndicator, centerInView: self)
                completion?()
            })
            
            self.layer.addAnimation(self.shrinkAnimation, forKey: "bounds")
            
            CATransaction.commit()
            
        case .Normal:

            self.layer.removeAllAnimations()
            self.activityIndicator.removeFromSuperview()
            self.setTitleColor(self.originalTitleColor, forState: .Normal)
        }
    }


}
