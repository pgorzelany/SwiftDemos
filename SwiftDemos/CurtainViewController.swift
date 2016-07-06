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
    @IBOutlet weak var portholeView: PortholeView!
    
    // MARK: Properties
    
    var videoCamera: GPUImageVideoCamera!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confgureController()
    }
    
    
    // MARK: Actions
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let location = recognizer.locationInView(self.portholeView)
        self.portholeView.holeOrigin = location
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
