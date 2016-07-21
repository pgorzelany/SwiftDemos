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
    
    let slideAnimator = SlideAnimator()
    let fadeAnimator = FadeInAnimator()
    
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
        detailController.transitioningDelegate = self.slideAnimator
        self.presentViewController(detailController, animated: true, completion: nil)
    }

    @IBAction func fillTransitionButtonTouched(sender: SubmitButton) {
        
        let currentState = self.fillButtonState
        
        switch currentState {
            
        case .Active:
            self.fillButtonState = .Normal
            sender.animateToState(.Normal, completion: { 
                
                print("Animated to state normal")
            })
            
        case .Normal:
            self.fillButtonState = .Active
            sender.animateToState(.Active, completion: { 
                
                print("Animated to active state")
                sender.animateFillScreen({ 
                    
                    print("Animated fill screen")
                    let detailController = DetailTransitionViewController.instantiateFromStoryboard()
//                    detailController.transitioningDelegate = self.fadeAnimator
                    self.presentViewController(detailController, animated: false, completion: nil)
                })
                
            })
        }

    }
    
    
    // MARK: Helpers
    
    
    // MARK: Appearance
    

}
