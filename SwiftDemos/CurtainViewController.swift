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
    @IBOutlet weak var bottomVideoView: GPUImageView!
    @IBOutlet weak var topVideoView: GPUImageView!
    
    
    // MARK: Properties
    
    var videoCamera: GPUImageVideoCamera!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confgureController()
        
    }
    
    
    // MARK: Actions
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let translationX: CGFloat = recognizer.translationInView(self.view).x
        
        let location = recognizer.locationInView(self.topVideoView)
        self.topVideoView.cutTransparentHoleWithRect(CGRect(x: 0, y: 0, width: translationX, height: self.topVideoView.bounds.size.height))
    }
    
    // MARK: Helpers
    
    private func confgureController() {

        self.addGestureRecognizers()
        self.configureCamera()
    }
    
    private func addGestureRecognizers() {

        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.view.addGestureRecognizer(panRecognizer)
    }
    
    private func configureCamera() {
        
        self.videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: AVCaptureDevicePosition.Back)
        self.videoCamera.outputImageOrientation = UIInterfaceOrientation.Portrait
        
        // configure top video view
        self.videoCamera.addTarget(self.topVideoView)
        
        // configure bottom video view
        
        let filter = GPUImageSepiaFilter()
        self.videoCamera.addTarget(filter)
        filter.addTarget(self.bottomVideoView)
        
        self.videoCamera.startCameraCapture()
    }
    
    // MARK: Appearance

}
