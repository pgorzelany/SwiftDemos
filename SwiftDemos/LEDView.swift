//
//  LEDView.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 15/01/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit
import RxSwift

class LEDView: UIView, NibInstantiable, LightEmittingDiode {

    // MARK: Outlets
    
    @IBOutlet weak var ledView: UIView!
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Properties
    
    var color = UIColor.red
    var disposeBag = DisposeBag()
    var brightness = 1.0 {
        didSet {
            self.alpha = CGFloat(brightness)
        }
    }
    var isOn = false

    // MARK: Methods
    
    func turnOn() {
        self.isOn = true
        self.ledView.backgroundColor = self.color
    }
    
    func turnOff() {
        self.isOn = false
        self.ledView.backgroundColor = UIColor.clear
    }
}
