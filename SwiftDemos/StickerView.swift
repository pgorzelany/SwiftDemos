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
    
    var removeButton = UIButton(type: UIButtonType.custom)
    
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
    
    fileprivate func configureView() {
        
        self.addRemoveButton()
    }
    
    fileprivate func addRemoveButton() {
        
        let buttonImage = UIImage(named: "icon-close-red")!
        self.removeButton.setImage(buttonImage, for: UIControlState())
        self.removeButton.addTarget(self, action: #selector(removeButtonTouched), for: UIControlEvents.touchUpInside)
//        self.removeButton.hidden = true
        
        self.removeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.removeButton)
        let views = ["subview": self.removeButton]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[subview]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
    }
    
    func setRemoveButtonHidden(_ hidden: Bool) {
        
        self.removeButton.isHidden = hidden
    }
    
}
