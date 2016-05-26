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
    private let menuTilt: CGFloat = 45
    
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
        self.addShadowToContentView()
        
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
        
        switch recognizer.state {
            
        case .Began:
            
            self.initialContentTranslation = self.contentViewCenterConstraint.constant
            
        case .Changed:
            
            self.translateContentView(inXDimension: translation.x + self.initialContentTranslation)
            
        case .Ended:
            
            self.handlePanGestureEnd()
            
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
        
        print("Content bounds width: \(self.contentContainerView.bounds.size.width)")
        print("Content frame width: \(self.contentContainerView.frame.size.width)")
        
        let relative3dAngleTranslation: CGFloat = -(self.menuTilt * relativeTranslation)
        let contentContainerViewWidthAfterTranslation = self.contentContainerView.bounds.size.width * cos(Angle.degreesToRadians(degrees: relative3dAngleTranslation))
        var relative3dXTranslation: CGFloat =  self.contentContainerView.bounds.size.width - contentContainerViewWidthAfterTranslation
        relative3dXTranslation = x > 0 ? -relative3dXTranslation : relative3dXTranslation
        
        print("Relative x translation: \(relative3dXTranslation)")
        
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / -1500;
        transform = CATransform3DRotate(transform, Angle.degreesToRadians(degrees: relative3dAngleTranslation), 0, 1, 0.0);
        transform = CATransform3DTranslate(transform, relative3dXTranslation, 0, 0)
        
        if animated {
            
            UIView.animateWithDuration(self.animationDuration, animations: { 
                
                self.contentContainerView.layer.transform = transform;
                self.view.layoutSubviews()
                
            })
            
        } else {
            
            self.contentContainerView.layer.transform = transform;
            
        }

    }
    
    private func handlePanGestureEnd() {
        
        if abs(self.contentViewCenterConstraint.constant) > self.maxAbsoluteContentTranslation / 3.0 {
            
            // Almost opened
            
            self.contentViewCenterConstraint.constant > 0 ? self.showMenu(.Left) : self.showMenu(.Right)
            
            
        } else {
            
            self.hideMenu()
            
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
    
    // MARK: Appearance
    
    private func addShadowToContentView() {

        self.contentContainerView.layer.shadowColor = UIColor.blackColor().CGColor
        self.contentContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.contentContainerView.layer.shadowOpacity = 0.8
        self.contentContainerView.layer.masksToBounds = false
        
    }
}
