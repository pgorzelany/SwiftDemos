//
//  CurtainViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class CurtainViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "CurtainViewDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var curtainView: CurtainView!
    
    // MARK: Properties
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confgureController()
    }
    
    
    // MARK: Actions
    
    
    // MARK: Helpers
    
    private func confgureController() {
        
        self.curtainView.delegate = self
    }
    
    // MARK: Appearance

}

extension CurtainViewController: CurtainViewDelegate {
    
    func curtainViewInitialView(view: CurtainView) -> UIView {
        
        let imageView = UIImageView(image: UIImage(named: "example-content"))
        return imageView
    }
    
    func curtainView(view: CurtainView, viewAfterView: UIView) -> UIView? {
        return nil
    }
    
    func curtainView(view: CurtainView, viewBeforeView: UIView) -> UIView? {
        return nil
    }
    
    
}
