//
//  ColorSliderViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 11/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ColorSliderViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "ColorSliderDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var colorSliderView: ColorSliderView!
    
    // MARK: Properties
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.colorSliderView.layer.borderColor = UIColor.white.cgColor
        self.colorSliderView.layer.borderWidth = 2.0
        self.colorSliderView.layer.cornerRadius = self.colorSliderView.bounds.size.height / 2.0
        self.colorSliderView.clipsToBounds = true
    }
    
    // MARK: Actions
    
    
    // MARK: Helpers
    
    fileprivate func configureController() {
        
        self.colorSliderView.delegate = self
    }
    
    // MARK: Appearance
    
    
}

extension ColorSliderViewController: ColorSliderViewDelegate {
    
    func colorSliderView(_ view: ColorSliderView, didSelectColor color: UIColor, atLocation location: CGPoint) {
        
        self.view.backgroundColor = color
    }
}
