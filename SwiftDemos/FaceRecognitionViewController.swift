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
    
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var faceDetector: CIDetector!
    
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
        self.configureFaceDetector()
    }
    
    private func configureCameraSession() {
        
        do {
            
            // capture session configuration
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            let input = try AVCaptureDeviceInput(device: device)
            self.captureSession.addInput(input)

            // preview layer
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.videoPreviewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
            self.videoPreviewLayer?.frame = self.cameraContainerView.bounds
            self.cameraContainerView.layer.insertSublayer(self.videoPreviewLayer!, atIndex: 0)
            
            // data output
            let videoDataOutput = AVCaptureVideoDataOutput()
            let rgbOutputSettings: NSDictionary = [String(kCVPixelBufferPixelFormatTypeKey): NSNumber(unsignedInt: kCMPixelFormat_32BGRA)]
            videoDataOutput.videoSettings = rgbOutputSettings as [NSObject : AnyObject]
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            let videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQue", DISPATCH_QUEUE_SERIAL)
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
            self.captureSession.addOutput(videoDataOutput)
            videoDataOutput.connectionWithMediaType(AVMediaTypeVideo).enabled = true
            
        } catch {
            
            let errorLabel = UILabel()
            errorLabel.text = "Could not initialize camera session"
            errorLabel.sizeToFit()
            self.view.addSubview(errorLabel, centerInView: self.cameraContainerView)
        }
    }
    
    private func configureFaceDetector() {
        
        let detectorOptions: [String: AnyObject] = [
            CIDetectorAccuracy: CIDetectorAccuracyHigh
        ]
        self.faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: detectorOptions)
    }
    
    // MARK: Data
    
    // MARK: Appearance

}

extension FaceRecognitionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer), attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate) {

            let image = CIImage(CVPixelBuffer: pixelBuffer, options: attachments as? [String: AnyObject])
            
            let deviceOrientation = UIDevice.currentDevice().orientation
            
            let imageOptions: [String: AnyObject] = [CIDetectorImageOrientation: 1]
            let features = self.faceDetector.featuresInImage(image, options: imageOptions)
            
            for feature in features {
                print("Feacure type: \(feature.type), with bounds: \(feature.bounds)")
            }
        }
        
    }
}
