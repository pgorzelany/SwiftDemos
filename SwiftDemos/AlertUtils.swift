//
//  AlertUtils.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 17/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import Foundation

struct AlertUtils {
    
    static func showAlert(title title: String, body: String?) {
        
        DemoAlertView.showAlert(title: title, body: body)
        
    }
    
}