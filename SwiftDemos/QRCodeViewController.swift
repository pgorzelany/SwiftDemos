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
    
    fileprivate var captureSession = AVCaptureSession()
    fileprivate var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
        self.captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.captureSession.stopRunning()
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    fileprivate func configureController() {
        
        self.configureCameraSession()
    }
    
    fileprivate func configureCameraSession() {
        
        do {
            
            // capture session configuration
            let device = AVCaptureDevice.default(for: .video)!
            let input = try AVCaptureDeviceInput(device: device)
            let output = AVCaptureMetadataOutput()
            self.captureSession.addInput(input)
            self.captureSession.addOutput(output)
            
            // qrcode metadata configuraton
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // preview layer
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
            self.videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            self.cameraContainerView.layer.insertSublayer(self.videoPreviewLayer!, at: 0)
            
        } catch {
            
            let errorLabel = UILabel()
            errorLabel.text = "Could not initialize camera session"
            errorLabel.sizeToFit()
            self.view.addSubview(errorLabel, centerInView: self.cameraContainerView)
        }
    }
    
    fileprivate func showQRCodeAlertWithCodeString(_ codeString: String) {
        
        self.captureSession.stopRunning()
        let alert = UIAlertController(title: "Wow!!!!", message: "You have just scanned a QRCode and its value is: \(codeString)", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Such Win!", style: UIAlertActionStyle.default) { (action) in
            
            self.captureSession.startRunning()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Data
    
    // MARK: Appearance

}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        for metadataObject in metadataObjects {
            
            if let codeObject = metadataObject as? AVMetadataMachineReadableCodeObject {
                
                let codeString = codeObject.stringValue
                self.showQRCodeAlertWithCodeString(codeString!)
            }
        }
    }
}
