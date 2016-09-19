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
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        
        print(#function)
        print(recognizer.translation(in: self.view))
        
    }
    
    func rotationGestureRecognized(_ recognizer: UIRotationGestureRecognizer) {
        
        print(#function)
        
        let rotation = recognizer.rotation
        
        self.rectangeView.transform = CGAffineTransform(rotationAngle: rotation)
        
    }
    
    func tapGestureRecognized(_ recognizer: UITapGestureRecognizer) {
        
        print(#function)
        let touchPoint = recognizer.location(in: self.rectangeView)
        
        UIView.animate(withDuration: 0.3, animations: { 
            
            self.rectangeView.transform = self.rectangeView.transform.translatedBy(x: touchPoint.x - self.rectangeView.center.x, y: touchPoint.y - self.rectangeView.center.y)
        }) 
        
    }
    
    // MARK: Helpers
    
    fileprivate func addGestureRecognizers() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureRecognized))
        
        self.rectangeView.addGestureRecognizer(panGesture)
        self.rectangeView.addGestureRecognizer(rotationGesture)
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: Appearance
    
    fileprivate func setInitialControllerAppearance() {
        
        rectangeView.backgroundColor = UIColor.red
        rectangeView.center = self.view.center
        self.view.addSubview(rectangeView)
        
    }
}
