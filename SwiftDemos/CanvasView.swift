//
//  CanvasView.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 06/09/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    // MARK: Properties
    
    private var paths: [CGMutablePath] = []
    
    private var currentPath: CGMutablePath?
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureView()
    }

    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        for path in self.paths + [self.currentPath].flatMap({$0}) {
            CGContextAddPath(context, path)
            CGContextSetLineWidth(context, 2.0)
            CGContextStrokePath(context)
        }
    }
    
    // MARK: Actions
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let location = recognizer.locationInView(self)
        
        switch recognizer.state {
            
        case .Began:
            self.currentPath = CGPathCreateMutable()
            CGPathMoveToPoint(self.currentPath, nil, location.x, location.y)
            
        case .Changed:
            CGPathAddLineToPoint(self.currentPath, nil, location.x, location.y)
            self.setNeedsDisplay()
            
        default: self.closeCurrentPath()
        }
    }
    
    // MARK: Methods
    
    private func configureView() {
        
        self.addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
    }
    
    private func closeCurrentPath() {
        
        if let currentPath = self.currentPath {
            self.paths.append(currentPath)
        }
        self.currentPath = nil
        self.setNeedsDisplay()
    }
    
    // MARK: Public methods
    
    func clear() {
        
        self.paths = []
        self.setNeedsDisplay()
    }

}
