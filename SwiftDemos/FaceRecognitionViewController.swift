//
//  FaceRecognitionViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 03/08/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

class FaceRecognitionViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "FaceRecognitionDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var cameraContainerView: UIView!
    
    
    // MARK: Properties
    
    fileprivate var captureSession = AVCaptureSession()
    fileprivate var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    fileprivate var faceDetector: CIDetector!
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.captureSession.stopRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
        
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    fileprivate func configureController() {
        
        self.configureCameraSession()
        self.configureFaceDetector()
    }
    
    fileprivate func configureCameraSession() {
        
        do {
            
            // capture session configuration
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            let input = try AVCaptureDeviceInput(device: device)
            self.captureSession.addInput(input)

            // preview layer
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.videoPreviewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
            self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
            self.cameraContainerView.layer.insertSublayer(self.videoPreviewLayer!, at: 0)
            
            // data output
            let videoDataOutput = AVCaptureVideoDataOutput()
            let rgbOutputSettings: NSDictionary = [String(kCVPixelBufferPixelFormatTypeKey): NSNumber(value: kCMPixelFormat_32BGRA as UInt32)]
            videoDataOutput.videoSettings = rgbOutputSettings as! [AnyHashable: Any]
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQue", attributes: [])
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
            self.captureSession.addOutput(videoDataOutput)
            videoDataOutput.connection(withMediaType: AVMediaTypeVideo).isEnabled = true
            
        } catch {
            
            let errorLabel = UILabel()
            errorLabel.text = "Could not initialize camera session"
            errorLabel.sizeToFit()
            self.view.addSubview(errorLabel, centerInView: self.cameraContainerView)
        }
    }
    
    fileprivate func configureFaceDetector() {
        
        let detectorOptions: [String: AnyObject] = [
            CIDetectorAccuracy: CIDetectorAccuracyHigh as AnyObject
        ]
        self.faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: detectorOptions)
    }
    
    // MARK: Data
    
    // MARK: Appearance

}

extension FaceRecognitionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer), let attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate) {

            let image = CIImage(cvPixelBuffer: pixelBuffer, options: attachments as? [String: AnyObject])
            
            
            let imageOptions: [String: AnyObject] = [CIDetectorImageOrientation: 1 as AnyObject]
            let features = self.faceDetector.features(in: image, options: imageOptions)
            
            for feature in features {
                print("Feacure type: \(feature.type), with bounds: \(feature.bounds)")
            }
        }
        
    }
}
