//
//  ScratchCardDemoViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 08/04/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit

class ScratchCardDemoViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static var storyboardId = "ScratchCardDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var scratchCardView: ScratchCardView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scratchCardView.delegate = self
    }
}

extension ScratchCardDemoViewController: ScratchCardViewDelegate {
    
    func contentView(for scratchCardView: ScratchCardView) -> UIView {
        let contentView = UIImageView(image: #imageLiteral(resourceName: "example-image"))
        return contentView
    }
    
    func coverView(for scratchCardView: ScratchCardView) -> UIView {
        let coverView = UIView()
        coverView.backgroundColor = UIColor.gray
        return coverView
    }
}
