//
//  LightEmittingDiode.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 15/01/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import Foundation
import RxSwift

protocol LightEmittingDiode: class {
    
    var disposeBag: DisposeBag {get set}
    // values from 0 to 1
    var brightness: Double {get set}
    var isOn: Bool {get}
    
    func turnOn()
    func turnOff()
    
}

extension LightEmittingDiode {
    
    func turnOn(withBrightness brightness: Double) {
        self.brightness = brightness
        self.turnOn()
    }
    
    /** Blink with frequency in Hertz */
    func blink(withFrequency frequency: Int) {
        self.disposeBag = DisposeBag()
        Observable<Int>.interval(1 / Double(frequency), scheduler: MainScheduler.instance)
            .subscribe { [weak self](_) in
                guard let strongSelf = self else {return}
                strongSelf.isOn ? strongSelf.turnOff() : strongSelf.turnOn()
            }.addDisposableTo(self.disposeBag)
    }
    
    func stopBlink() {
        self.disposeBag = DisposeBag()
        self.turnOff()
    }
}
