//
//  CGPoint+Extensions.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 12/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}