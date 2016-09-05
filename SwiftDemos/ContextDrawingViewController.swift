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
        
        for _ in 0..<3 {
            
            let manipulableView = ManipulableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
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
