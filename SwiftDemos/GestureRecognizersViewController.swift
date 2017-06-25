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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print(#function)
        
    }
    
    @objc func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        
        resultLabel.text = "\(#function)!"
        
    }
    
    @objc func doubleTapGestureRecognized(_ sender: UITapGestureRecognizer) {
        
        resultLabel.text = #function
        
    }
    
    @objc func rotationGestureRecognized(_ sender: UIRotationGestureRecognizer) {
        
        resultLabel.text = #function
        
    }
    
    @objc func panGestureRecognized(_ sender: UIRotationGestureRecognizer) {
        
        resultLabel.text = #function
        
    }
    
    @objc func swipeGestureRecognized(_ sender: UIRotationGestureRecognizer) {
        
        resultLabel.text = #function
        
    }
    
    // MARK: Support
    
    fileprivate func addGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapGestureRecognized(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        
        // To make the double tap recognizer to work, we must make the normal tap gesture to wait for the double tap to fail
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureRecognized(_:)))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecognized(_:)))
        
        panGestureRecognizer.require(toFail: swipeGestureRecognizer)
        
        self.recognizerView.addGestureRecognizer(tapGestureRecognizer)
        self.recognizerView.addGestureRecognizer(doubleTapGestureRecognizer)
        self.recognizerView.addGestureRecognizer(rotationGestureRecognizer)
        self.recognizerView.addGestureRecognizer(panGestureRecognizer)
        self.recognizerView.addGestureRecognizer(swipeGestureRecognizer)
        
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
