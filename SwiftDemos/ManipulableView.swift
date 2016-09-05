//
//  ManipulableView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 11/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ManipulableView: UIView {
    
    // MARK: Properties
    
    var tapRecognizer: UITapGestureRecognizer!
    var panRecognizer: UIPanGestureRecognizer!
    var pinchRecognizer: UIPinchGestureRecognizer!
    var rotationRecognizer: UIRotationGestureRecognizer!
    
    /** The initial transform value when initiating view panning */
    var initialTranslationTransform = CGAffineTransformIdentity
    
    var minScaleFactor: CGFloat = 0.5
    
    var maxScaleFactor: CGFloat = 2.0
    
    /** The view center after apllying translation transform */
    var translatedCenter: CGPoint {
        let translation = CGPoint(x: self.transform.tx, y: self.transform.ty)
        return self.center + translation
    }
    
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
        
    }
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translationInView(self)
        
        switch recognizer.state {
            
        case .Began:
            
            self.initialTranslationTransform = self.transform
            
        case .Changed:
            
            self.transform = CGAffineTransformTranslate(self.initialTranslationTransform, translation.x, translation.y)
            
        default: break
        }
    }
    
    func pinchGestureRecognized(recognizer: UIPinchGestureRecognizer) {
        
        switch recognizer.state {
            
        case .Changed:
            
            let newScaleTransform = CGAffineTransformScale(self.transform, recognizer.scale, recognizer.scale)
            let newScale = self.scaleFromTransform(newScaleTransform)
            if newScale >= self.minScaleFactor && newScale <= self.maxScaleFactor {
                self.transform = CGAffineTransformScale(self.transform, recognizer.scale, recognizer.scale)
            }
            
        default: break
        }
        
        recognizer.scale = 1
    }
    
    func rotationGestureRecognized(recognizer: UIRotationGestureRecognizer) {
        
        switch recognizer.state {
            
        case .Changed:
            self.transform = CGAffineTransformRotate(self.transform, recognizer.rotation)
            
        default: break
        }
        
        recognizer.rotation = 0
        
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
    
    func scaleFromTransform(transform: CGAffineTransform) -> CGFloat {
        
        return CGFloat(sqrt(Double(transform.a * transform.a + transform.c * transform.c)))
    }
    
    // MARK: Appearance
    
    
}

extension ManipulableView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if (gestureRecognizer is UIRotationGestureRecognizer || otherGestureRecognizer is UIRotationGestureRecognizer) && (gestureRecognizer is UIPinchGestureRecognizer || otherGestureRecognizer is UIPinchGestureRecognizer) {
            return true
        }
        
        return false
    }
}
