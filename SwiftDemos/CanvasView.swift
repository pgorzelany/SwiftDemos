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
    
    fileprivate var paths: [CGMutablePath] = []
    
    fileprivate var currentPath: CGMutablePath?
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureView()
    }
    
    init(strokePaths paths: [CGMutablePath]) {
        self.init()
        
        self.paths = paths
    }

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        for path in self.paths + [self.currentPath].flatMap({$0}) {
            context?.addPath(path)
            context?.setLineWidth(40.0)
            context?.strokePath()
        }
    }
    
    // MARK: Actions
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        
        let location = recognizer.location(in: self)
        
        switch recognizer.state {
        case .began:
            self.beginPath(at: location)
        case .changed:
            self.addLine(to: location)
        default:
            self.closeCurrentPath()
        }
    }
    
    // MARK: Public methods
    
    func beginPath(at point: CGPoint) {
        self.currentPath = CGMutablePath()
        self.currentPath?.move(to: point)
    }
    
    func addLine(to point: CGPoint) {
        self.currentPath?.addLine(to: point)
        self.setNeedsDisplay()
    }
    
    func closeCurrentPath() {
        if let currentPath = self.currentPath {
            self.paths.append(currentPath)
        }
        self.currentPath = nil
        self.setNeedsDisplay()
    }
    
    // MARK: Methods
    
    fileprivate func configureView() {
        
        self.addGestureRecognizers()
    }
    
    fileprivate func addGestureRecognizers() {
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
    }
    
    // MARK: Public methods
    
    func clear() {
        
        self.paths = []
        self.setNeedsDisplay()
    }

}
