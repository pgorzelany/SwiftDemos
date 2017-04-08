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
    
    let colors = [UIColor.black, UIColor.green, UIColor.green, UIColor.blue]
    var currentColorIndex = 0
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    
    // MARK: Actions
    
    @IBAction func addShapeButtonTouched(_ sender: UIButton) {
        
        self.addManipulableView()
    }
    
    // MARK: Helpers
    
    func configureController() {
        
    }
    
    fileprivate func addManipulableView() {
        
        let manipulableView = StickerView(frame: CGRect(origin: self.view.center, size: CGSize(width: 100, height: 100)))
        let color = colors[currentColorIndex % colors.count]
        self.currentColorIndex += 1
        manipulableView.backgroundColor = color
        self.view.addSubview(manipulableView)
    }
    
    
    // MARK: Appearance

}
