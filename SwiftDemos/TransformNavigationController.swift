//
//  TransformNavigationController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 16/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class TransformNavigationController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "TransformNavigationController"
    
    // MARK: Outlets
    
    @IBOutlet weak var contantContainerView: UIView!
    
    @IBOutlet weak var leftMenuContainerView: UIView!
    
    @IBOutlet weak var rightMenuContainerView: UIView!
    
    
    // MARK: Properties
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transform Navigation Controller"
        
        self.addGestureRecognizers()
        
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    fileprivate func addGestureRecognizers() {
        
        self.addPanGestureRecognizer()
        self.addTapGestureRecognizer()
        
    }
    
    fileprivate func addPanGestureRecognizer() {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    fileprivate func addTapGestureRecognizer() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func panGestureRecognized(_ recognizer: UIPanGestureRecognizer) {
        
        print("Gesture translation in view: \(recognizer.translation(in: self.view))")
        let translationX = recognizer.translation(in: self.view).x
        
        let transform = CGAffineTransform(translationX: translationX, y: 0)
        self.contantContainerView.transform = transform
        
    }
    
    func tapGestureRecognized(_ recognizer: UITapGestureRecognizer) {
        
        self.contantContainerView.transform = CGAffineTransform.identity
        
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
