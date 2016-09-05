//
//  ContextDrawingViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 14/08/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ContextDrawingViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "ContextDrawingDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Properties
    
    let exampleImage = UIImage(named: "example-image")!
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: Actions
    
    @IBAction func redrawButtonTouched(sender: UIButton) {
        
        self.draw()
    }
    
    
    // MARK: Support
    
    private func draw() {
        
        let drawingRect = self.imageView.bounds
        UIGraphicsBeginImageContextWithOptions(drawingRect.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
            CGContextFillRect(context, drawingRect)
            CGContextSaveGState(context)
            CGContextRotateCTM(context, Angle.degreesToRadians(degrees: 180))
            self.exampleImage.drawInRect(CGRect(x: -100, y: -100, width: 100, height: 100))
            CGContextRestoreGState(context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.imageView.image = image
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        UIGraphicsEndImageContext()
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
