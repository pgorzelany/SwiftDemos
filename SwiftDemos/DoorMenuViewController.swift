//
//  DoorMenuViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 22/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class DoorMenuViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "DoorMenu"
    
    // MARK: Outlets
    
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var leftMenuContainerView: UIView!
    @IBOutlet weak var rightMenuContainerView: UIView!
    
    @IBOutlet weak var contentViewCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftMenuWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightMenuWidthConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    
    /** The width of the menu container as a percentage of the screen */
    var menuWidth: CGFloat = 0.7
    
    private var maxAbsoluteContentTranslation: CGFloat {
        return UIScreen.mainScreen().bounds.width * self.menuWidth
    }
    
    /** The maximum angle (in degrees) the door menu can open */
    var menuTilt: CGFloat = 20
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Door Menu"
        self.configureController()
        
        
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    private func configureController(){
        
        print("menu width: \(self.maxAbsoluteContentTranslation)")
        self.leftMenuWidthConstraint.constant = self.maxAbsoluteContentTranslation
        self.rightMenuWidthConstraint.constant = self.maxAbsoluteContentTranslation
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translationInView(self.view)
        self.translateContentView(inXDimension: translation.x)
        
    }
    
    private func translateContentView(inXDimension x: CGFloat) {
        
        guard abs(x) <= self.maxAbsoluteContentTranslation else {return}
        
        let relativeTranslation = x / maxAbsoluteContentTranslation
        
        self.contentViewCenterConstraint.constant = x
        
        // 3d transforms
        
        let relativeAngleTranslation: CGFloat = self.menuTilt * relativeTranslation
        
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / -700;
        transform = CATransform3DRotate(transform, -relativeAngleTranslation * CGFloat(M_PI / 180.0), 0, 1, 0.0);

        self.contentContainerView.layer.transform = transform;
        

    }
    
    // MARK: Data
    
    // MARK: Appearance
}
