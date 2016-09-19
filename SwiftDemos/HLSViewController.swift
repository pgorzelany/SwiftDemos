//
//  HLSViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 14/08/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import MediaPlayer

class HLSViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "HLSDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var mainContainer: UIView!
    
    // MARK: Properties
    
    var moviePlayerController = MPMoviePlayerController()
    
    let movieUrl = URL(string: "http://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8")!
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    deinit {
        
        self.moviePlayerController.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    // MARK: Actions
    
    @IBAction func startStopButtonTouched(_ sender: UIButton) {
        
        self.moviePlayerController.play()
    }
    
    // MARK: Support
    
    fileprivate func configureController() {
        
        self.moviePlayerController.contentURL = self.movieUrl
        self.moviePlayerController.movieSourceType = MPMovieSourceType.file
        self.moviePlayerController.controlStyle = .fullscreen
        self.mainContainer.addSubviewFullscreen(self.moviePlayerController.view)
        self.moviePlayerController.prepareToPlay()
    }
    
    // MARK: Data
    
    // MARK: Appearance
}
