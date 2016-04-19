//
//  GestureRecognizersViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 19/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class GestureRecognizersViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "GestureRecognizers"
    
    // MARK: Outlets
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var recognizerView: UIView!
    
    // MARK: Properties
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGestureRecognizers()
    }
    
    // MARK: Actions
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print(#function)
        
    }
    
    func tapGestureRecognized(sender: UITapGestureRecognizer) {
        
        resultLabel.text = "\(#function)!"
        
    }
    
    func doubleTapGestureRecognized(sender: UITapGestureRecognizer) {
        
        resultLabel.text = #function
        
    }
    
    func rotationGestureRecognized(sender: UIRotationGestureRecognizer) {
        
        resultLabel.text = #function
        
    }
    
    func panGestureRecognized(sender: UIRotationGestureRecognizer) {
        
        resultLabel.text = #function
        
    }
    
    func swipeGestureRecognized(sender: UIRotationGestureRecognizer) {
        
        resultLabel.text = #function
        
    }
    
    // MARK: Support
    
    private func addGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapGestureRecognized(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        
        // To make the double tap recognizer to work, we must make the normal tap gesture to wait for the double tap to fail
        tapGestureRecognizer.requireGestureRecognizerToFail(doubleTapGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureRecognized(_:)))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecognized(_:)))
        
        panGestureRecognizer.requireGestureRecognizerToFail(swipeGestureRecognizer)
        
        self.recognizerView.addGestureRecognizer(tapGestureRecognizer)
        self.recognizerView.addGestureRecognizer(doubleTapGestureRecognizer)
        self.recognizerView.addGestureRecognizer(rotationGestureRecognizer)
        self.recognizerView.addGestureRecognizer(panGestureRecognizer)
        self.recognizerView.addGestureRecognizer(swipeGestureRecognizer)
        
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
