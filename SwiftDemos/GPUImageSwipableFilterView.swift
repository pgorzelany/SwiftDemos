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
    
    var topGPUImageView: GPUImageView {
        return self.subviews.last! as! GPUImageView
    }
    var bottomGPUImageView: GPUImageView {
        return self.subviews.first! as! GPUImageView
    }
    
    var currentFilter = GPUImageFilter()
    var bottomFilter = GPUImageFilter()
    
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
                self.bottomFilter = delegate?.gpuImageSwipableFilterViewPreviousFilter(self) ?? GPUImageFilter()
            } else {
                self.bottomFilter = delegate?.gpuImageSwipableFilterViewNextFilter(self) ?? GPUImageFilter()
            }
            
            self.updateFilterTargets()
            
        case .Changed:
            
            self.topGPUImageView.cutTransparentHoleWithRect(holeRect)
            
        case .Ended:
            
            self.handleGestureEnd()
            
        default: break
            
        }
        
    }
    
    // MARK: Methods
    
    private func configureView() {
        
        self.addSubviewFullscreen(GPUImageView())
        self.addSubviewFullscreen(GPUImageView())
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
        
        self.configureCamera()
    }
    
    private func configureCamera() {
        
        self.videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: AVCaptureDevicePosition.Back)
        self.videoCamera.outputImageOrientation = UIInterfaceOrientation.Portrait
        
        self.updateFilterTargets()
        
        self.videoCamera.startCameraCapture()
    }
    
    private func updateFilterTargets() {
        
        self.videoCamera.removeAllTargets()
        self.currentFilter.removeAllTargets()
        self.bottomFilter.removeAllTargets()
        
        self.videoCamera.addTarget(self.currentFilter)
        self.currentFilter.addTarget(self.topGPUImageView)
        
        self.videoCamera.addTarget(self.bottomFilter)
        
        self.bottomFilter.addTarget(bottomGPUImageView)
    }
    
    private func handleGestureEnd() {
    
        self.topGPUImageView.cutTransparentHoleWithRect(CGRectZero)
        self.currentFilter = self.bottomFilter
        self.switchViews()
    }
    
    private func switchViews() {

        self.exchangeSubviewAtIndex(1, withSubviewAtIndex: 0)
    }

}
