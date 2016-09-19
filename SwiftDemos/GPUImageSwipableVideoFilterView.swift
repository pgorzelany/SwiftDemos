//
//  GPUImageSwipableVideoFilterView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 07/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation

class GPUImageSwipableVideoFilterView: GPUImageView {
    
    // MARK: Properties
    
    var topGPUImageView: GPUImageView {
        return self.subviews.last! as! GPUImageView
    }
    var bottomGPUImageView: GPUImageView {
        return self.subviews.first! as! GPUImageView
    }
    
    var sourceUrl: URL!
    
    var filters = [GPUImageFilter]()
    var currentFilterIndex: Int {
        return self.filters.index(of: self.currentFilter)!
    }
    var currentFilter = GPUImageFilter()
    var bottomFilter = GPUImageFilter()
    
    fileprivate var videoPlayer = AVPlayer()
    fileprivate var playerItem:AVPlayerItem!
    fileprivate var gpuMovie:GPUImageMovie!
    fileprivate var videoOrientation:UIInterfaceOrientation = .portrait
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(videoSourceUrl: URL, filters: [GPUImageFilter]) {
        self.init(frame: CGRect.zero)
        
        self.filters = filters
        self.sourceUrl = videoSourceUrl
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
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        
        let xTranslation = recognizer.translation(in: self).x
        
        let topRightCorner = CGPoint(x: self.bounds.width - abs(xTranslation), y: 0)
        let holeOrigin = xTranslation > 0 ? self.bounds.origin : topRightCorner
        let holeRect = CGRect(origin: holeOrigin, size: CGSize(width: abs(xTranslation), height: self.bounds.height))
        
        switch recognizer.state {
            
        case .began:
            
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

            self.topGPUImageView.cutTransparentHoleWithRect(holeRect)
            
        case .ended:

            if abs(xTranslation) > self.bounds.width / 2.0 {
                self.commitFilterChange()
            } else {
                self.rollbackFilterChange()
            }
            
        default:
            
            self.rollbackFilterChange()
            
        }
        
    }
    
    // MARK: Public Methods
    
    func startPlayback() {
        
        self.videoPlayer.play()
        self.gpuMovie.startProcessing()
    }
    
    func stopPlayback() {
        
        self.videoPlayer.pause()
        self.gpuMovie.endProcessing()
    }
    
    // MARK: Methods
    
    fileprivate func configureView() {
        
        self.addSubviewFullscreen(GPUImageView())
        self.addSubviewFullscreen(GPUImageView())
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
        
        self.configurePlayer()
    }
    
    fileprivate func configurePlayer() {
        
        self.playerItem = AVPlayerItem(url: self.sourceUrl)
        self.videoPlayer.replaceCurrentItem(with: self.playerItem)
        
        self.gpuMovie = GPUImageMovie(playerItem: self.playerItem)
        self.gpuMovie.playAtActualSpeed = true
        
        self.updateFilterTargets()
        
    }
    
    fileprivate func updateFilterTargets() {
        
        self.gpuMovie.endProcessing()
        
        self.gpuMovie.removeAllTargets()
        self.currentFilter.removeAllTargets()
        self.bottomFilter.removeAllTargets()
        
        self.gpuMovie.addTarget(self.currentFilter)
        self.currentFilter.addTarget(self.topGPUImageView)
        
        self.gpuMovie.addTarget(self.bottomFilter)
        self.bottomFilter.addTarget(bottomGPUImageView)
        
        self.gpuMovie.startProcessing()
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
