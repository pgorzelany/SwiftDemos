//
//  CurtainViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import GPUImage

class CurtainViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "CurtainViewDemo"
    
    // MARK: Outlets
    
//    @IBOutlet weak var curtainView: CurtainView!
//    @IBOutlet weak var portholeView: PortholeView!
    @IBOutlet weak var portholeView: GPUImageView!
    
    
    // MARK: Properties
    
    var videoCamera: GPUImageVideoCamera!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confgureController()
        self.addTransparentMask()
        
    }
    
    
    // MARK: Actions
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let location = recognizer.locationInView(self.portholeView)
//        self.portholeView.holeOrigin = location
    }
    
    // MARK: Helpers
    
    private func confgureController() {

        self.addGestureRecognizers()
        self.configureCamera()
    }
    
    private func addGestureRecognizers() {

//        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
//        self.view.addGestureRecognizer(panRecognizer)
    }
    
    private func addTransparentMask() {
        
//        int radius = myRect.size.width;
//        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.mapView.bounds.size.width, self.mapView.bounds.size.height) cornerRadius:0];
//        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius];
//        [path appendPath:circlePath];
//        [path setUsesEvenOddFillRule:YES];
//        
//        CAShapeLayer *fillLayer = [CAShapeLayer layer];
//        fillLayer.path = path.CGPath;
//        fillLayer.fillRule = kCAFillRuleEvenOdd;
//        fillLayer.fillColor = [UIColor grayColor].CGColor;
//        fillLayer.opacity = 0.5;
//        [view.layer addSublayer:fillLayer];
        
        let fillLayer = CAShapeLayer()
        var path = UIBezierPath(rect: self.portholeView.bounds)
        path.appendPath(UIBezierPath(rect: CGRect(x: 100, y: 100, width: 50, height: 50)))
        fillLayer.path = path.CGPath
        fillLayer.fillColor = UIColor.redColor().CGColor
        fillLayer.fillRule = kCAFillRuleEvenOdd
//        fillLayer.opacity = 0
        self.portholeView.layer.mask = fillLayer
    }
    
    private func configureCamera() {
        
        self.videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: AVCaptureDevicePosition.Back)
        self.videoCamera.outputImageOrientation = UIInterfaceOrientation.Portrait
        
//        let gpuImageView = GPUImageView()
//        self.portholeView.addSubviewFullscreen(self.portholeView)
        
        self.videoCamera.addTarget(self.portholeView)
        self.videoCamera.startCameraCapture()
    }
    
    // MARK: Appearance

}

extension CurtainViewController: CurtainViewDelegate {
    
    func curtainViewInitialView(view: CurtainView) -> UIView {
        
        let imageView = UIImageView(image: UIImage(named: "example-content"))
        return imageView
    }
    
    func curtainView(view: CurtainView, viewAfterView: UIView) -> UIView? {
        return nil
    }
    
    func curtainView(view: CurtainView, viewBeforeView: UIView) -> UIView? {
        return nil
    }
    
    
}
