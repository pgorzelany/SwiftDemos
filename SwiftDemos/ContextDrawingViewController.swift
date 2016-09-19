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
    
    
    @IBAction func captureSceneButtonTouched(_ sender: UIButton) {
        
        self.captureScene()
    }
    
    // MARK: Support
    
    fileprivate func configureController() {
        
        let words = ["rotate me", "resize me", "move me"]
        
        for word in words {
            
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 32)
            label.textAlignment = .center
            label.text = word
            label.sizeToFit()
            label.bounds = label.bounds.insetBy(dx: -20, dy: -20)
            let manipulableView = ManipulableView(frame: label.bounds)
            manipulableView.addSubviewFullscreen(label)
            manipulableView.center = canvasView.center
            manipulableView.backgroundColor = UIColor.red
            self.canvasView.addSubview(manipulableView)
        }
    }
    
    fileprivate func captureScene() {
        
        let drawingRect = CGRect(origin: CGPoint(x: 0, y:0), size: self.exampleImage.size)
        UIGraphicsBeginImageContextWithOptions(drawingRect.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            let yScale =  drawingRect.size.height / self.canvasView.bounds.size.height
            let xScale = drawingRect.size.width / self.canvasView.bounds.size.width
            context.scaleBy(x: xScale, y: yScale)
            print("Drawing rect size: \(drawingRect.size)")
            self.canvasView.layer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//        AlertUtils.showAlert(title: "Scene saved to photo album", body: nil)
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
