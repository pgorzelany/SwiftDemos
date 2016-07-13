//
//  StickerView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 13/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class StickerView: ManipulableView {
    
    // MARK: Properties
    
    var removeButton = UIButton(type: UIButtonType.Custom)
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureView()
    }
    
    // MARK: Actions
    
    func removeButtonTouched() {
        
        self.removeFromSuperview()
    }
    
    // MARK: Methods
    
    private func configureView() {
        
        self.addRemoveButton()
    }
    
    private func addRemoveButton() {
        
        let buttonImage = UIImage(named: "icon-close-red")!
        self.removeButton.setImage(buttonImage, forState: UIControlState.Normal)
        self.removeButton.addTarget(self, action: #selector(removeButtonTouched), forControlEvents: UIControlEvents.TouchUpInside)
        self.removeButton.hidden = true
        
        self.removeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.removeButton)
        let views = ["subview": self.removeButton]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[subview]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
    }
    
    func setRemoveButtonHidden(hidden: Bool) {
        
        self.removeButton.hidden = hidden
    }
    
}
