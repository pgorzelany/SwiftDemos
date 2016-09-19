    //
//  DoorMenuViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 22/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

private enum Side {
    
    case left, right
    
}
    
protocol DoorMenuDelegate {
    
    func doorMenuDelegateWillShowLeftMenu(_ menu: DoorMenuViewController)
    func doorMenuDelegateWillShowRightMenu(_ menu: DoorMenuViewController)
    func doorMenuDelegateWillHideLeftMenu(_ menu: DoorMenuViewController)
    func doorMenuDelegateWillHideRightMenu(_ menu: DoorMenuViewController)
    
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
    var menuWidth: CGFloat = 0.75
    
    fileprivate var maxAbsoluteContentTranslation: CGFloat {
        return UIScreen.main.bounds.width * self.menuWidth
    }
    
    /** The maximum angle (in degrees) the door menu can open */
    fileprivate let menuTilt: CGFloat = 45
    
    /** Content translation at the beggining of the pan gesture */
    fileprivate var initialContentTranslation: CGFloat = 0
    
    fileprivate var animating = false
    
    fileprivate let animationDuration: TimeInterval = 0.5
    
    fileprivate var isLeftMenuShown: Bool {
        
        return self.contentViewCenterConstraint.constant == self.maxAbsoluteContentTranslation
        
    }
    
    fileprivate var isRightMenuShown: Bool {
        
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
    
    @IBAction func leftButtonTouched(_ sender: UIButton) {
        
        self.toggleLeftMenu()
        
    }
    
    @IBAction func rightButtonTouched(_ sender: UIButton) {
        
        self.toggleRightMenu()
        
    }
    
    // MARK: Support
    
    fileprivate func configureController(){
        
        self.leftMenuWidthConstraint.constant = self.maxAbsoluteContentTranslation
        self.rightMenuWidthConstraint.constant = self.maxAbsoluteContentTranslation
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        
        switch recognizer.state {
            
        case .began:
            
            self.initialContentTranslation = self.contentViewCenterConstraint.constant
            
        case .changed:
            
            self.translateContentView(inXDimension: translation.x + self.initialContentTranslation)
            
        case .ended:
            
            self.handlePanGestureEnd()
            
        default:
            
            break
            
        }
        
    }
    
    /** The absolute translation to make on the content view */
    fileprivate func translateContentView(inXDimension x: CGFloat, animated: Bool = false) {
        
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
            
            UIView.animate(withDuration: self.animationDuration, animations: { 
                
                self.contentContainerView.layer.transform = transform;
                self.view.layoutSubviews()
                
            })
            
        } else {
            
            self.contentContainerView.layer.transform = transform;
            
        }

    }
    
    fileprivate func handlePanGestureEnd() {
        
        if abs(self.contentViewCenterConstraint.constant) > self.maxAbsoluteContentTranslation / 3.0 {
            
            // Almost opened
            
            self.contentViewCenterConstraint.constant > 0 ? self.showMenu(.left) : self.showMenu(.right)
            
            
        } else {
            
            self.hideMenu()
            
        }
        
    }
    
    fileprivate func showMenu(_ side: Side) {
        
        let translation = side == .left ? self.maxAbsoluteContentTranslation : -self.maxAbsoluteContentTranslation
        
        self.translateContentView(inXDimension: translation, animated: true)
        
    }
    
    fileprivate func hideMenu() {
        
        self.contentViewCenterConstraint.constant = 0
        
        UIView.animate(withDuration: self.animationDuration, animations: { 
            
            self.contentContainerView.layer.transform = CATransform3DIdentity
            self.view.layoutSubviews()
            
        }) 
        
    }
    
    fileprivate func toggleMenu(_ side: Side) {
        
        if self.isLeftMenuShown || self.isRightMenuShown {
            
            self.hideMenu()
            
        } else {
            
            self.showMenu(side)
        }
        
    }
    
    func toggleLeftMenu() {
        
        self.toggleMenu(.left)
        
    }
    
    func toggleRightMenu() {
        
        self.toggleMenu(.right)
    }
    
    // MARK: Appearance
    
    fileprivate func addShadowToContentView() {

        self.contentContainerView.layer.shadowColor = UIColor.black.cgColor
        self.contentContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.contentContainerView.layer.shadowOpacity = 0.8
        self.contentContainerView.layer.masksToBounds = false
        
    }
}
