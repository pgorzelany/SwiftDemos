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
    
    private var canvasView = CanvasView()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        canvasView.frame = topView.bounds
    }
    
    // MARK: Configuration
    
    private func configureView() {
        self.addGestureRecognizers()
        bottomView.backgroundColor = UIColor.red
        topView.backgroundColor = UIColor.blue
        let testPath = CGMutablePath()
        testPath.move(to: CGPoint(x: 0, y: 0))
        testPath.addLine(to: CGPoint(x: 50, y: 50))
        canvasView = CanvasView(strokePaths: [testPath])
        canvasView.backgroundColor = UIColor.clear
//        addSubviewFullscreen(canvasView)
        addSubviewFullscreen(bottomView)
        addSubviewFullscreen(topView)
//        canvasView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        canvasView.frame = topView.bounds
        topView.mask = canvasView
        canvasView.beginPath(at: CGPoint(x: 50, y: 0))
        canvasView.addLine(to: CGPoint(x: 0, y: 50))
        canvasView.closeCurrentPath()
    }
    
    fileprivate func addGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
    }
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        canvasView.panGestureRecognized(recognizer)
    }
}
