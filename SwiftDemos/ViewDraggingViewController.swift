//
//  ViewDraggingViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 19/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ViewDraggingViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "ViewDragging"
    
    // MARK: Outlets
    
    // MARK: Properties
    
    var draggableView: DraggableView!
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Draggable View"
        
        self.addDraggableView()
    }
    
    // MARK: Support
    
    func addDraggableView() {
        
        draggableView = DraggableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        draggableView.center = self.view.center
        draggableView.backgroundColor = UIColor.redColor()
        self.view.addSubview(draggableView)
        
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
