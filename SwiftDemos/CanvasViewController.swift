//
//  CanvasViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 06/09/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "CanvasDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var canvasView: CanvasView!
    
    // MARK: Properties
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: Actions
    
    @IBAction func clearButtonTouched(_ sender: UIButton) {
        
        self.canvasView.clear()
    }
    
    // MARK: Support
    
    // MARK: Data
    
    // MARK: Appearance

}
