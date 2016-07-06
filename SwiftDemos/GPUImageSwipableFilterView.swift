//
//  GPUImageSwipableFilterView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 06/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import GPUImage

protocol GPUImageSwipableFilterViewDelegate: class {
    
    func gpuImageSwipableFilterViewNextFilter(view: GPUImageSwipableFilterView) -> GPUImageFilter
    
    func gpuImageSwipableFilterViewPreviousFilter(view: GPUImageSwipableFilterView) -> GPUImageFilter
    
}

class GPUImageSwipableFilterView: GPUImageView {

    // MARK: Properties
    
    weak var delegate: GPUImageSwipableFilterViewDelegate?
    
    var topGPUImageView = GPUImageView()
    var bottomGPUImageView = GPUImageView()
    
    var videoCamera: GPUImageVideoCamera!
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    // MARK: Actions
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let xTranslation = recognizer.translationInView(self).x
        print(xTranslation)
        
        let topRightCorner = CGPoint(x: self.bounds.width - abs(xTranslation), y: 0)
        let holeOrigin = xTranslation > 0 ? self.bounds.origin : topRightCorner
        let holeRect = CGRect(origin: holeOrigin, size: CGSize(width: abs(xTranslation), height: self.bounds.height))
        
        switch recognizer.state {
            
        case .Began:
            
            if xTranslation > 0 {
                delegate?.gpuImageSwipableFilterViewPreviousFilter(self)
            } else {
                delegate?.gpuImageSwipableFilterViewNextFilter(self)
            }
            
        case .Changed:
            
            self.topGPUImageView.cutTransparentHoleWithRect(holeRect)
            
        case .Ended:
            
            self.handleGestureEnd()
            
        default: break
            
        }
        
    }
    
    // MARK: Methods
    
    private func configureView() {
        
        self.addSubviewFullscreen(self.bottomGPUImageView)
        self.addSubviewFullscreen(self.topGPUImageView)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
        
        self.configureCamera()
    }
    
    private func configureCamera() {
        
        self.videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: AVCaptureDevicePosition.Back)
        self.videoCamera.outputImageOrientation = UIInterfaceOrientation.Portrait
        
        self.videoCamera.addTarget(self.topGPUImageView)
        
        let filter = GPUImageSepiaFilter()
        self.videoCamera.addTarget(filter)
        filter.addTarget(self.bottomGPUImageView)
        
        self.videoCamera.startCameraCapture()
    }
    
    private func handleGestureEnd() {
    
        self.topGPUImageView.cutTransparentHoleWithRect(CGRectZero)
        self.switchViews()
    }
    
    private func switchViews() {
        
        (self.topGPUImageView, self.bottomGPUImageView) = (self.bottomGPUImageView, self.topGPUImageView)
        self.exchangeSubviewAtIndex(1, withSubviewAtIndex: 0)
    }

}
