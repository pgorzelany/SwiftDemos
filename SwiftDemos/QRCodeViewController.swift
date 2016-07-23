//
//  QRCodeViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 23/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: StoryboardInstantiable
    
    static let storyboardId = "QRCodeDemo"
    
    // MARK: Outlets
    
    @IBOutlet var cameraContainerView: UIView!
    
    // MARK: Properties
    
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
        self.captureSession.startRunning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.captureSession.stopRunning()
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
            
            // qrcode metadata configuraton
            
            output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            // preview layer
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
            self.videoPreviewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
            self.cameraContainerView.layer.insertSublayer(self.videoPreviewLayer!, atIndex: 0)
            
        } catch {
            
            let errorLabel = UILabel()
            errorLabel.text = "Could not initialize camera session"
            errorLabel.sizeToFit()
            self.view.addSubview(errorLabel, centerInView: self.cameraContainerView)
        }
    }
    
    private func showQRCodeAlertWithCodeString(codeString: String) {
        
        self.captureSession.stopRunning()
        let alert = UIAlertController(title: "Wow!!!!", message: "You have just scanned a QRCode and its value is: \(codeString)", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Such Win!", style: UIAlertActionStyle.Default) { (action) in
            
            self.captureSession.startRunning()
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: Data
    
    // MARK: Appearance

}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        for metadataObject in metadataObjects {
            
            if let codeObject = metadataObject as? AVMetadataMachineReadableCodeObject {
                
                let codeString = codeObject.stringValue
                self.showQRCodeAlertWithCodeString(codeString)
            }
        }
    }
}
