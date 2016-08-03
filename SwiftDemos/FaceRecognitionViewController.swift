//
//  FaceRecognitionViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 03/08/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import AVFoundation

class FaceRecognitionViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "FaceRecognitionDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var cameraContainerView: UIView!
    
    
    // MARK: Properties
    
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.captureSession.startRunning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.captureSession.stopRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
        
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    private func configureController() {
        
        self.configureCameraSession()
    }
    
    private func configureCameraSession() {
        
        do {
            
            // capture session configuration
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            let input = try AVCaptureDeviceInput(device: device)
            let output = AVCaptureMetadataOutput()
            self.captureSession.addInput(input)
            self.captureSession.addOutput(output)

            // preview layer
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.videoPreviewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
            self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
            self.cameraContainerView.layer.insertSublayer(self.videoPreviewLayer!, atIndex: 0)
            
        } catch {
            
            let errorLabel = UILabel()
            errorLabel.text = "Could not initialize camera session"
            errorLabel.sizeToFit()
            self.view.addSubview(errorLabel, centerInView: self.cameraContainerView)
        }
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
