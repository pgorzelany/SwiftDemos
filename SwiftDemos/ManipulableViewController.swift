//
//  ManipulableViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 11/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ManipulableViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "ManipulableViewDemo"
    
    // MARK: Outlets
    
    
    // MARK: Properties
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    
    // MARK: Actions
    
    
    // MARK: Helpers
    
    func configureController() {
        
        let manipulableView = ManipulableView(frame: CGRect(origin: self.view.center, size: CGSize(width: 200, height: 200)))
        manipulableView.backgroundColor = UIColor.redColor()
        self.view.addSubview(manipulableView)
    }
    
    
    // MARK: Appearance

}
