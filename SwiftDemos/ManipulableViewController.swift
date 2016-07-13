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
    
    let colors = [UIColor.blackColor(), UIColor.greenColor(), UIColor.greenColor(), UIColor.blueColor()]
    var currentColorIndex = 0
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    
    // MARK: Actions
    
    @IBAction func addShapeButtonTouched(sender: UIButton) {
        
        self.addManipulableView()
    }
    
    // MARK: Helpers
    
    func configureController() {
        
    }
    
    private func addManipulableView() {
        
        let manipulableView = StickerView(frame: CGRect(origin: self.view.center, size: CGSize(width: 200, height: 200)))
        let color = colors[currentColorIndex % colors.count]
        self.currentColorIndex += 1
        manipulableView.backgroundColor = color
        self.view.addSubview(manipulableView)
    }
    
    
    // MARK: Appearance

}
