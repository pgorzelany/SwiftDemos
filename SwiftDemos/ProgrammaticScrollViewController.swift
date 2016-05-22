//
//  ProgrammaticScrollViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 18/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ProgrammaticScrollViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "ProgrammaticScrollView"
    
    // MARK: Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var conentViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conentViewHeightConstraint.constant = 1000
        self.scrollViewBottomConstraint.constant = 100
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    // MARK: Data
    
    // MARK: Appearance

}
