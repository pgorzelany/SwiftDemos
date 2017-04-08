//
//  ScratchCardView.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 08/04/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ScratchCardView: UIView {

    // MARK: Properties
    
    var topView = UIView()
    var bottomView = UIView()
    
    private var scratchPaths = [CGMutablePath]()
    private var currentPath: CGMutablePath?
    
    // MARK: Delegate
    
    
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
    }
    
    // MARK: Configuration
    
    private func configureView() {
        bottomView.backgroundColor = UIColor.red
        topView.backgroundColor = UIColor.blue
        addSubviewFullscreen(bottomView)
        addSubviewFullscreen(topView)
        addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        addGestureRecognizer(panRecognizer)
    }
    
    // MARK: Actions
    
    @objc private func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        switch recognizer.state {
            
        case .began:
            currentPath = CGMutablePath()
            currentPath?.move(to: location)
            
        case .changed:
            currentPath?.addLine(to: location)
            
        default: closeCurrentPath()
        }
    }
    
    // MARK: Helpers
    
    fileprivate func closeCurrentPath() {
        if let currentPath = currentPath {
            scratchPaths.append(currentPath)
        }
        let maskLayer = CAShapeLayer()
        maskLayer.path = currentPath
        maskLayer.lineWidth = 20
        maskLayer.strokeColor = UIColor.white.cgColor
        topView.layer.mask = maskLayer
        currentPath = nil
        
    }

}
