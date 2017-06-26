//
//  Double+Extensions.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 26/06/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import Foundation

extension Double {
    
    /** Rounds a number to the specified number of decimal places */
    func round(precision: Int) -> Double {
        let precisionMultiplier = pow(10.0, Double(precision))
        return (self * precisionMultiplier).rounded(.down) / precisionMultiplier
    }
}
