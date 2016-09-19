//
//  StoryboardInstantiable.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 14/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
    
    static var storyboardId: String {get}
    
    static var storyboardControllerId: String {get}
    
    static func instantiateFromStoryboard() -> UIViewController
    
}


extension StoryboardInstantiable where Self: UIViewController {
    
    static var storyboardControllerId: String {
        return String(describing: Self.self)
    }
    
    static func instantiateFromStoryboard() -> UIViewController {
        
        let storyboard = UIStoryboard(name: Self.storyboardId, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: Self.storyboardControllerId)
        
    }
    
}
