    //
//  DoorMenuViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 22/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

private enum Side {
    
    case Left, Right
    
}

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
    var menuWidth: CGFloat = 0.8
    
    private var maxAbsoluteContentTranslation: CGFloat {
        return UIScreen.mainScreen().bounds.width * self.menuWidth
    }
    
    /** The maximum angle (in degrees) the door menu can open */
    private let menuTilt: CGFloat = 30
    
    /** Content translation at the beggining of the pan gesture */
    private var initialContentTranslation: CGFloat = 0
    
    private var animating = false
    
    private let animationDuration: NSTimeInterval = 0.5
    
    private var isLeftMenuShown: Bool {
        
        return self.contentViewCenterConstraint.constant == self.maxAbsoluteContentTranslation
        
    }
    
    private var isRightMenuShown: Bool {
        
        return self.contentViewCenterConstraint.constant == -self.maxAbsoluteContentTranslation
        
    }
    
    
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Door Menu"
        self.configureController()
        
        
    }
    
    // MARK: Actions
    
    @IBAction func leftButtonTouched(sender: UIButton) {
        
        self.toggleLeftMenu()
        
    }
    
    @IBAction func rightButtonTouched(sender: UIButton) {
        
        self.toggleRightMenu()
        
    }
    
    // MARK: Support
    
    private func configureController(){
        
        self.leftMenuWidthConstraint.constant = self.maxAbsoluteContentTranslation
        self.rightMenuWidthConstraint.constant = self.maxAbsoluteContentTranslation
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translationInView(self.view)
        print(translation)
        
        switch recognizer.state {
            
        case .Began:
            
            self.initialContentTranslation = self.contentViewCenterConstraint.constant
            
        case .Changed:
            
            self.translateContentView(inXDimension: translation.x + self.initialContentTranslation)
            
        default:
            
            break
            
        }
        
    }
    
    /** The absolute translation to make on the content view */
    private func translateContentView(inXDimension x: CGFloat, animated: Bool = false) {
        
        guard abs(x) <= self.maxAbsoluteContentTranslation else {return}
        
        let relativeTranslation = x / maxAbsoluteContentTranslation
        
        self.contentViewCenterConstraint.constant = x
        
        // 3d transforms
        
        let relativeAngleTranslation: CGFloat = self.menuTilt * relativeTranslation
        
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / -700;
        transform = CATransform3DRotate(transform, -relativeAngleTranslation * CGFloat(M_PI / 180.0), 0, 1, 0.0);
        
        if animated {
            
            UIView.animateWithDuration(self.animationDuration, animations: { 
                
                self.contentContainerView.layer.transform = transform;
                self.view.layoutSubviews()
                
            })
            
        } else {
            
            self.contentContainerView.layer.transform = transform;
            
        }

    }
    
    private func showMenu(side: Side) {
        
        let translation = side == .Left ? self.maxAbsoluteContentTranslation : -self.maxAbsoluteContentTranslation
        
        self.translateContentView(inXDimension: translation, animated: true)
        
    }
    
    private func hideMenu() {
        
        self.contentViewCenterConstraint.constant = 0
        
        UIView.animateWithDuration(self.animationDuration) { 
            
            self.contentContainerView.layer.transform = CATransform3DIdentity
            self.view.layoutSubviews()
            
        }
        
    }
    
    private func toggleMenu(side: Side) {
        
        if self.isLeftMenuShown || self.isRightMenuShown {
            
            self.hideMenu()
            
        } else {
            
            self.showMenu(side)
        }
        
    }
    
    func toggleLeftMenu() {
        
        self.toggleMenu(.Left)
        
    }
    
    func toggleRightMenu() {
        
        self.toggleMenu(.Right)
    }
    
    
    
    // MARK: Data
    
    // MARK: Appearance
}
