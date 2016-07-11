//
//  ColorSliderView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 11/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

protocol ColorSliderViewDelegate: class {
    
    
    func colorSliderView(view: ColorSliderView, didSelectColor color: UIColor)
}

class ColorSliderView: UIView {
    
    // MARK: Properties
    
    var sliderLocation = CGPoint(x: 0, y: 0) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var sliderWidth: CGFloat = 5
    var sliderColor = UIColor.whiteColor()
    
    // MARK: Delegate
    
    weak var delegate: ColorSliderViewDelegate?
    
    // MARK: Lifecycle
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let chunkWidth: CGFloat = 1
        var currentPostition = CGPoint(x: 0, y: 0)
        
        // draw rainbow background
        
        while currentPostition.x <= self.bounds.size.width {
            let path = UIBezierPath(rect: CGRect(origin: currentPostition, size: CGSize(width: chunkWidth, height: self.bounds.size.height)))
            let color = self.colorForLocation(currentPostition)
            color?.setFill()
            path.fill()
            currentPostition.x += chunkWidth
        }
        
        // draw slider
        let sliderOrigin = CGPoint(x: self.sliderLocation.x - (self.sliderWidth / 2.0), y: 0)
        let path = UIBezierPath(rect: CGRect(origin: sliderOrigin, size: CGSize(width: sliderWidth, height: self.bounds.size.height)))
        self.sliderColor.setFill()
        path.fill()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    // MARK: Actions 
    
    func tapGestureRecognized(recognizer: UITapGestureRecognizer) {
        
        let location = recognizer.locationInView(self)
        if let color = self.colorForLocation(location) {
            self.sliderLocation = location
            delegate?.colorSliderView(self, didSelectColor: color)
        }
    }
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let location = recognizer.locationInView(self)
        if let color = self.colorForLocation(location) {
            self.sliderLocation = location
            delegate?.colorSliderView(self, didSelectColor: color)
        }
    }
    
    // MARK: Configuration
    
    private func configureView() {
        
        self.configureGestureRecognizers()
        self.setSliderInitialLocation()
    }
    
    private func configureGestureRecognizers() {
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        
        self.addGestureRecognizer(tapRecognizer)
        self.addGestureRecognizer(panRecognizer)
    }
    
    private func setSliderInitialLocation() {
        
        self.sliderLocation = CGPoint(x: self.bounds.size.width / 2.0, y: 0)
    }
    
    // MARK: Methods
    
    /** Get the color associated with the position of touch in view */
    private func colorForLocation(location: CGPoint) -> UIColor? {
        
        guard location.x >= 0 && location.x <= self.bounds.size.width else {return nil}
        
        let colorHue = location.x / self.bounds.size.width
        let color = UIColor(hue: colorHue, saturation: 1, brightness: 1, alpha: 1)
        return color
    }
    
    

}
