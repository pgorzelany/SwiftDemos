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
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Properties
    
    let exampleImage = UIImage(named: "example-image")!
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    // MARK: Actions
    
    
    @IBAction func captureSceneButtonTouched(sender: UIButton) {
        
        self.captureScene()
    }
    
    // MARK: Support
    
    private func configureController() {
        
        let words = ["rotate me", "resize me", "move me"]
        
        for word in words {
            
            let label = UILabel()
            label.font = UIFont.boldSystemFontOfSize(32)
            label.textAlignment = .Center
            label.text = word
            label.sizeToFit()
            label.bounds = label.bounds.insetBy(dx: -20, dy: -20)
            let manipulableView = ManipulableView(frame: label.bounds)
            manipulableView.addSubviewFullscreen(label)
            manipulableView.center = canvasView.center
            manipulableView.backgroundColor = UIColor.redColor()
            self.canvasView.addSubview(manipulableView)
        }
    }
    
    private func captureScene() {
        
        let drawingRect = CGRect(origin: CGPoint(x: 0, y:0), size: self.exampleImage.size)
        UIGraphicsBeginImageContextWithOptions(drawingRect.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            let yScale =  drawingRect.size.height / self.canvasView.bounds.size.height
            let xScale = drawingRect.size.width / self.canvasView.bounds.size.width
            CGContextScaleCTM(context, xScale, yScale)
            print("Drawing rect size: \(drawingRect.size)")
            self.canvasView.layer.renderInContext(context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        UIGraphicsEndImageContext()
        AlertUtils.showAlert(title: "Scene saved to photo album", body: nil)
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
