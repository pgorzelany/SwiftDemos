//
//  CurtainViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import GPUImage

class SwipableVideoFilterViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "SwipableVideoFiltersDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var swipableFilterViewContainer: UIView!
    var swipableFilterView: GPUImageSwipableFilterView!
    
    // MARK: Properties
    
    var videoCamera: GPUImageVideoCamera!
    
    var curentFilterIndex = 0
    
    let filters = [GPUImageFilter(), GPUImageSepiaFilter(), GPUImageColorInvertFilter(), GPUImageMonochromeFilter()]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.swipableFilterView.
    }
    
    
    // MARK: Actions

    
    // MARK: Helpers
    
    private func configureController() {
        
         self.swipableFilterView = GPUImageSwipableFilterView(filters: self.filters)
//        let videoUrl = NSBundle.mainBundle().URLForResource("sample-video", withExtension: "mov")!
//        self.swipableFilterView = GPUImageSwipableVideoFilterView(videoSourceUrl: videoUrl, filters: self.filters)
        self.swipableFilterViewContainer.addSubviewFullscreen(self.swipableFilterView)
    }
    
    // MARK: Appearance

}

