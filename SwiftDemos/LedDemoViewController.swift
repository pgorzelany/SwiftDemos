//
//  LedDemoViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 15/01/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit

class LedDemoViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "LEDDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var ledContainer: UIView!
    
    // MARK: Properties
    
    let ledView = LEDView.instantiateFromNib()
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    // MARK: Configuration
    
    private func configureController() {
        ledContainer.addSubviewFullscreen(ledView)
        self.ledView.turnOn()
    }
    
    // MARK: Actions
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        sender.isOn ? self.ledView.turnOn() : self.ledView.turnOff()
    }
    
    @IBAction func blinkTouched(_ sender: UIButton) {
        self.ledView.blink(withFrequency: 2)
    }
    
    @IBAction func stopBlinkTouched(_ sender: UIButton) {
        self.ledView.stopBlink()
    }
    
    // MARK: Support
    
    // MARK: Data
    
    // MARK: Appearance
}
