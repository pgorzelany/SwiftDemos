//
//  CurtainViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import GPUImage

class CurtainViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "CurtainViewDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var swipableFilterView: GPUImageSwipableFilterView!
    
    // MARK: Properties
    
    var videoCamera: GPUImageVideoCamera!
    
    var curentFilterIndex = 0
    
    let filters = [GPUImageSepiaFilter(), GPUImageColorInvertFilter(), GPUImageMonochromeFilter()]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
        
    }
    
    
    // MARK: Actions

    
    // MARK: Helpers
    
    private func configureController() {
        
        self.swipableFilterView.delegate = self
    }
    
    // MARK: Appearance

}

extension CurtainViewController: GPUImageSwipableFilterViewDelegate {
    
    func gpuImageSwipableFilterViewNextFilter(view: GPUImageSwipableFilterView) -> GPUImageFilter {
        
        let filterIndex = (self.curentFilterIndex) % (self.filters.count)
        self.curentFilterIndex = self.curentFilterIndex + 1
        
        return self.filters[filterIndex]
        
    }
    
    func gpuImageSwipableFilterViewPreviousFilter(view: GPUImageSwipableFilterView) -> GPUImageFilter {
        
        return GPUImageHazeFilter()
    }
    
}
