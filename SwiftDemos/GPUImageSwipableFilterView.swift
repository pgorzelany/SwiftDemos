//
//  GPUImageSwipableFilterView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 06/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import GPUImage

class GPUImageSwipableFilterView: GPUImageView {

    // MARK: Properties
    
    var topGPUImageView: GPUImageView {
        return self.subviews.last! as! GPUImageView
    }
    var bottomGPUImageView: GPUImageView {
        return self.subviews.first! as! GPUImageView
    }
    
    var filters = [GPUImageFilter]()
    var currentFilterIndex: Int {
        return self.filters.index(of: self.currentFilter)!
    }
    var currentFilter = GPUImageFilter()
    var bottomFilter = GPUImageFilter()
    
    var videoCamera: GPUImageVideoCamera!
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(filters: [GPUImageFilter]) {
        self.init(frame: CGRect.zero)
        
        self.filters = filters
        if let firstFilter = filters.first {
            self.currentFilter = firstFilter
        }
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
    
    @objc func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        
        let xTranslation = recognizer.translation(in: self).x
        print(xTranslation)
        
        let topRightCorner = CGPoint(x: self.bounds.width - abs(xTranslation), y: 0)
        let holeOrigin = xTranslation > 0 ? self.bounds.origin : topRightCorner
        let holeRect = CGRect(origin: holeOrigin, size: CGSize(width: abs(xTranslation), height: self.bounds.height))
        
        switch recognizer.state {
            
        case .began:
            
            print("Gesture Begin")
            
            if xTranslation > 0 {
                
                guard self.currentFilterIndex > 0 else {
                    recognizer.cancel()
                    return
                }

                self.bottomFilter = self.filters[self.currentFilterIndex - 1]
                
            } else {
                
                guard self.currentFilterIndex < self.filters.count - 1 else {
                    recognizer.cancel()
                    return
                }
                self.bottomFilter = self.filters[self.currentFilterIndex + 1]
            }
            
            self.updateFilterTargets()
            
        case .changed:
            
            print("Gesture changed")
            
            self.topGPUImageView.cutTransparentHoleWithRect(holeRect)
            
        case .ended:
            
            print("Gesture ended")
            
            if abs(xTranslation) > self.bounds.width / 2.0 {
                self.commitFilterChange()
            } else {
                self.rollbackFilterChange()
            }
            
        default:
            
            self.rollbackFilterChange()
            
        }
        
    }
    
    // MARK: Methods
    
    fileprivate func configureView() {
        
        self.addSubviewFullscreen(GPUImageView())
        self.addSubviewFullscreen(GPUImageView())
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
        
        self.configureCamera()
    }
    
    fileprivate func configureCamera() {
        
        self.videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.vga640x480.rawValue, cameraPosition: AVCaptureDevice.Position.back)
        self.videoCamera.outputImageOrientation = UIInterfaceOrientation.portrait
        
        self.updateFilterTargets()
        
        self.videoCamera.startCapture()
    }
    
    fileprivate func updateFilterTargets() {
        
        self.videoCamera.removeAllTargets()
        self.currentFilter.removeAllTargets()
        self.bottomFilter.removeAllTargets()
        
        self.videoCamera.addTarget(self.currentFilter)
        self.currentFilter.addTarget(self.topGPUImageView)
        
        self.videoCamera.addTarget(self.bottomFilter)
        
        self.bottomFilter.addTarget(bottomGPUImageView)
    }
    
    fileprivate func commitFilterChange() {
        
        self.topGPUImageView.cutTransparentHoleWithRect(CGRect.zero)
        self.currentFilter = self.bottomFilter
        self.switchViews()
    }
    
    fileprivate func rollbackFilterChange() {
        
        self.topGPUImageView.cutTransparentHoleWithRect(CGRect.zero)
    }
    
    fileprivate func switchViews() {

        self.exchangeSubview(at: 1, withSubviewAt: 0)
    }

}
