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
    
    var titleColorForNormalState = UIColor.blackColor()
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
            
            self.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
            
            UIView.animateWithDuration(self.animationDuration, animations: { 
                
                let scale = self.frame.size.height / self.frame.size.width
                self.transform = CGAffineTransformMakeScale(scale, 1)
                
            }, completion: { (finished) in
                
                self.activityIndicator.startAnimating()
                self.superview?.addSubview(self.activityIndicator, centerInView: self)
                completion?()
            })
            
        case .Normal:
            
            self.activityIndicator.removeFromSuperview()
            
            UIView.animateWithDuration(self.animationDuration, animations: { 
                
                self.transform = CGAffineTransformIdentity
                
            }, completion: { (finished) in
                
                self.setTitleColor(self.titleColorForNormalState, forState: UIControlState.Normal)
                completion?()
            })
        }
    }


}
