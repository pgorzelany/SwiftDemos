//
//  DetailTransitionViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class DetailTransitionViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "ControllerTransitions"
    
    // MARK: Outlets
    
    
    // MARK: Properties
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    // MARK: Actions
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
    
    
    // MARK: Appearance

}
