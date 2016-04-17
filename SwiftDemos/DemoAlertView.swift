//
//  DemoAlertView.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 17/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class DemoAlertView: UIView, NibInstantiable {
    
    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    
    // MARK: Actions
    
    @IBAction func okButtonTouched(sender: UIButton) {
        
        UIView.animateWithDuration(0.3, animations: { 
            
            self.alpha = 0.3
            
        }) { (finished) in
            
            self.removeFromSuperview()
            
        }
        
    }
    
    // MARK: Helpers
    
    static func showAlert(title title: String, body: String?) {
        
        let alert = DemoAlertView.instantiateFromNib()
        alert.titleLabel.text = title
        alert.bodyLabel.text = body
        let window = UIApplication.sharedApplication().keyWindow!
        window.addSubviewFullscreen(alert)
        
    }

}
