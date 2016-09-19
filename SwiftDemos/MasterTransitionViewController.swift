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
    
    var fillButtonState = SubmitButton.State.normal
    
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
    
    @IBAction func presentButtonTouched(_ sender: UIButton) {
        
        let detailController = DetailTransitionViewController.instantiateFromStoryboard()
        detailController.transitioningDelegate = self.slideAnimator
        self.present(detailController, animated: true, completion: nil)
    }

    @IBAction func fillTransitionButtonTouched(_ sender: SubmitButton) {
        
        let currentState = self.fillButtonState
        
        switch currentState {
            
        case .active:
            self.fillButtonState = .normal
            sender.animateToState(.normal, completion: { 
                
                print("Animated to state normal")
            })
            
        case .normal:
            self.fillButtonState = .active
            sender.animateToState(.active, completion: { 
                
                print("Animated to active state")
                sender.animateFillScreen({ 
                    
                    print("Animated fill screen")
                    let detailController = DetailTransitionViewController.instantiateFromStoryboard()
//                    detailController.transitioningDelegate = self.fadeAnimator
                    self.present(detailController, animated: false, completion: nil)
                })
                
            })
        }

    }
    
    
    // MARK: Helpers
    
    
    // MARK: Appearance
    

}
