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
    
    private func addGestureRecognizers() {
        
        self.addPanGestureRecognizer()
        self.addTapGestureRecognizer()
        
    }
    
    private func addPanGestureRecognizer() {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    private func addTapGestureRecognizer() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        print("Gesture translation in view: \(recognizer.translationInView(self.view))")
        let translationX = recognizer.translationInView(self.view).x
        
        let transform = CGAffineTransformMakeTranslation(translationX, 0)
        self.contantContainerView.transform = transform
        
    }
    
    func tapGestureRecognized(recognizer: UITapGestureRecognizer) {
        
        self.contantContainerView.transform = CGAffineTransformIdentity
        
    }
    
    // MARK: Data
    
    // MARK: Appearance

}
