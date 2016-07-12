//
//  ManipulableView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 11/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ManipulableView: UIView {

    // Outlets
    
    
    
    // MARK: Properties
    
    var tapRecognizer: UITapGestureRecognizer!
    var panRecognizer: UIPanGestureRecognizer!
    var pinchRecognizer: UIPinchGestureRecognizer!
    var rotationRecognizer: UIRotationGestureRecognizer!
    
    /** The center offset when panning the view */
    var centerOffset = CGPointZero
    
    /** The initial transform value when initiating view scaling */
    var initialScaleTransform = CGAffineTransformIdentity
    
    /** The initial transform value when initiating view rotation */
    var initialRotationTransform = CGAffineTransformIdentity
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureView()
    }
    
    // MARK: Actions
    
    func tapGestureRecognized(recognizer: UITapGestureRecognizer) {
        print(#function)
        
    }
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        print(#function)
        
        let location = recognizer.locationInView(self.superview)
        
        switch recognizer.state {
            
        case .Began:
            self.centerOffset = location - self.center
            
        case .Changed:
            self.center = location - centerOffset
            
        default: break
        }
    }
    
    func pinchGestureRecognized(recognizer: UIPinchGestureRecognizer) {
        print(#function)
        
        print("Recognizer scale: \(recognizer.scale)")
        guard recognizer.scale >= 0.5 && recognizer.scale <= 2.0 else {return}
        
        switch recognizer.state {
            
        case .Began:
            self.initialScaleTransform = self.transform
            self.transform = CGAffineTransformScale(self.initialScaleTransform, recognizer.scale, recognizer.scale)
            
        case .Changed:
            self.transform = CGAffineTransformScale(self.initialScaleTransform, recognizer.scale, recognizer.scale)
            
        default: break
        }
    }
    
    func rotationGestureRecognized(recognizer: UIRotationGestureRecognizer) {
        print(#function)
        
        
        switch recognizer.state {
            
        case .Began:
            self.initialRotationTransform = self.transform
            self.transform = CGAffineTransformRotate(self.initialRotationTransform, recognizer.rotation)
            
        case .Changed:
            self.transform = CGAffineTransformRotate(self.initialRotationTransform, recognizer.rotation)
            
        default: break
        }
    }
    
    // MARK: Helpers
    
    private func configureView() {
        
        self.configureGestureRecognizers()
    }
    
    private func configureGestureRecognizers() {
        
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.panRecognizer.maximumNumberOfTouches = 1
        self.pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognized))
        self.rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureRecognized))
        self.rotationRecognizer.delegate = self
        self.pinchRecognizer.delegate = self
        
        self.addGestureRecognizer(tapRecognizer)
        self.addGestureRecognizer(panRecognizer)
        self.addGestureRecognizer(pinchRecognizer)
        self.addGestureRecognizer(rotationRecognizer)
    }
    
    // MARK: Appearance
    

}

extension ManipulableView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if (gestureRecognizer is UIRotationGestureRecognizer || otherGestureRecognizer is UIRotationGestureRecognizer) && (gestureRecognizer is UIPinchGestureRecognizer || otherGestureRecognizer is UIPinchGestureRecognizer) {
            return true
        }
        
        return true
    }
}
