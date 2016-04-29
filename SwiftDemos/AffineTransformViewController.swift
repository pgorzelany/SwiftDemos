//
//  AffineTransformViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 29/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class AffineTransformViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "AffineTransform"
    
    // MARK: Outlets
    
    
    // MARK: Properties
    
    var rectangeView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setInitialControllerAppearance()
        self.addGestureRecognizers()
    }
    
    
    // MARK: Actions
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        print(#function)
        print(recognizer.translationInView(self.view))
        
    }
    
    func rotationGestureRecognized(recognizer: UIRotationGestureRecognizer) {
        
        print(#function)
        
        let rotation = recognizer.rotation
        
        self.rectangeView.transform = CGAffineTransformMakeRotation(rotation)
        
    }
    
    func tapGestureRecognized(recognizer: UITapGestureRecognizer) {
        
        print(#function)
        let touchPoint = recognizer.locationInView(self.rectangeView)
        
        UIView.animateWithDuration(0.3) { 
            
            self.rectangeView.transform = CGAffineTransformTranslate(self.rectangeView.transform, touchPoint.x - self.rectangeView.center.x, touchPoint.y - self.rectangeView.center.y)
        }
        
    }
    
    // MARK: Helpers
    
    private func addGestureRecognizers() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureRecognized))
        
        self.rectangeView.addGestureRecognizer(panGesture)
        self.rectangeView.addGestureRecognizer(rotationGesture)
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: Appearance
    
    private func setInitialControllerAppearance() {
        
        rectangeView.backgroundColor = UIColor.redColor()
        rectangeView.center = self.view.center
        self.view.addSubview(rectangeView)
        
    }
}
