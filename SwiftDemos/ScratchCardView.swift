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
    
    var coverView = UIView()
    var contentView = UIView()
    
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
        
        canvasView.frame = contentView.bounds
    }
    
    // MARK: Configuration
    
    private func configureView() {
        self.addGestureRecognizers()
        let imageView = UIImageView(image: #imageLiteral(resourceName: "example-image"))
        contentView.addSubviewFullscreen(imageView)
        contentView.backgroundColor = UIColor.red
        coverView.backgroundColor = UIColor.blue
        canvasView.backgroundColor = UIColor.clear
        addSubviewFullscreen(coverView)
        addSubviewFullscreen(contentView)
        contentView.mask = canvasView
    }
    
    fileprivate func addGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
    }
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        canvasView.panGestureRecognized(recognizer)
    }
}
