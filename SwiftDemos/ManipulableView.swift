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
    var initialTranslationTransform = CGAffineTransform.identity
    
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
    
    func tapGestureRecognized(_ recognizer: UITapGestureRecognizer) {
        
    }
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self)
        
        switch recognizer.state {
            
        case .began:
            
            self.initialTranslationTransform = self.transform
            
        case .changed:
            
            self.transform = self.initialTranslationTransform.translatedBy(x: translation.x, y: translation.y)
            
        default: break
        }
    }
    
    func pinchGestureRecognized(_ recognizer: UIPinchGestureRecognizer) {
        
        switch recognizer.state {
            
        case .changed:
            
            let newScaleTransform = self.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            let newScale = self.scaleFromTransform(newScaleTransform)
            if newScale >= self.minScaleFactor && newScale <= self.maxScaleFactor {
                self.transform = self.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            }
            
        default: break
        }
        
        recognizer.scale = 1
    }
    
    func rotationGestureRecognized(_ recognizer: UIRotationGestureRecognizer) {
        
        switch recognizer.state {
            
        case .changed:
            self.transform = self.transform.rotated(by: recognizer.rotation)
            
        default: break
        }
        
        recognizer.rotation = 0
        
    }
    
    // MARK: Helpers
    
    fileprivate func configureView() {
        
        self.configureGestureRecognizers()
    }
    
    fileprivate func configureGestureRecognizers() {
        
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
    
    func scaleFromTransform(_ transform: CGAffineTransform) -> CGFloat {
        
        return CGFloat(sqrt(Double(transform.a * transform.a + transform.c * transform.c)))
    }
    
    // MARK: Appearance
    
    
}

extension ManipulableView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if (gestureRecognizer is UIRotationGestureRecognizer || otherGestureRecognizer is UIRotationGestureRecognizer) && (gestureRecognizer is UIPinchGestureRecognizer || otherGestureRecognizer is UIPinchGestureRecognizer) {
            return true
        }
        
        return false
    }
}
