//
//  UIGestureRecgonizer+Extensions.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 06/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    
    func cancel() {
        self.enabled = false
        self.enabled = true
    }
    
}