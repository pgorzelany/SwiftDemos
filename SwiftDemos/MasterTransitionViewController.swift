//
//  MasterTransitionViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class MasterTransitionViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "ControllerTransitions"
    
    // MARK: Outlets
    
    @IBOutlet weak var fillTransitionButton: SubmitButton!
    
    
    // MARK: Properties
    
    var fillButtonState = SubmitButton.State.Normal
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.fillTransitionButton.setRoundedCorners()
    }
    
    
    // MARK: Actions
    
    @IBAction func presentButtonTouched(sender: UIButton) {
        
        let detailController = DetailTransitionViewController.instantiateFromStoryboard()
        detailController.transitioningDelegate = self
        self.presentViewController(detailController, animated: true, completion: nil)
    }

    @IBAction func fillTransitionButtonTouched(sender: SubmitButton) {
        
        let currentState = self.fillButtonState
        
        switch currentState {
            
        case .Active:
            self.fillButtonState = .Normal
            sender.animateToState(.Normal, completion: { 
                
                print("Animated to normal state")
            })
            
        case .Normal:
            self.fillButtonState = .Active
            sender.animateToState(.Active, completion: { 
                
                print("Animated to active state")
            })
        }

    }
    
    
    // MARK: Helpers
    
    
    // MARK: Appearance
    

}

extension MasterTransitionViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = SlideAnimator()
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = SlideAnimator()
        animator.presenting = false
        return animator
    }
    
}
