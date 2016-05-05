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
    
    
    // MARK: Properties
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    // MARK: Actions
    
    @IBAction func presentButtonTouched(sender: UIButton) {
        
        let detailController = DetailTransitionViewController.instantiateFromStoryboard()
        detailController.transitioningDelegate = self
        self.presentViewController(detailController, animated: true, completion: nil)
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
