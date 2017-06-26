//
//  CoreMotionViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 25/06/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit
import CoreMotion

class MotionViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "CoreMotion"
    
    // MARK: Outlets
    
    @IBOutlet weak var gravityLabel: UILabel!
    @IBOutlet weak var userAccelerationLabel: UILabel!
    @IBOutlet weak var attitudeLabel: UILabel!
    @IBOutlet weak var rotationRateLabel: UILabel!
    @IBOutlet weak var magneticFieldLabel: UILabel!
    
    // MARK: Properties
    
    private let motionManager = CMMotionManager()
    private let motionQueue = OperationQueue()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startMotionManager()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopMotionManager()
    }
    
    // MARK: Configuration
    
    private func configureController() {
        configureOperationQueue()
        configureMotionManager()
    }
    
    private func configureOperationQueue() {
        motionQueue.maxConcurrentOperationCount = 1
        motionQueue.qualityOfService = .userInteractive
        
    }
    
    private func configureMotionManager() {
        motionManager.deviceMotionUpdateInterval = 0.5
    }
    
    // MARK: Methods
    
    private func startMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: handleDeviceMotionUpdate)
        }
    }
    
    private func stopMotionManager() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    private func handleDeviceMotionUpdate(data: CMDeviceMotion?, error: Error?) {
        guard let data = data else {
            return
        }
        
        DispatchQueue.main.async {
            let x = data.gravity.x.round(precision: 2)
            let y = data.gravity.y.round(precision: 2)
            let z = data.gravity.y.round(precision: 2)
            self.gravityLabel.text = "x: \(x), y: \(y), z: \(z)"
            
            let accX = data.userAcceleration.x.round(precision: 2)
            let accY = data.userAcceleration.y.round(precision: 2)
            let accZ = data.userAcceleration.z.round(precision: 2)
            self.userAccelerationLabel.text = "x: \(accX), y: \(accY), z: \(accZ)"
            
            let rotationX = data.rotationRate.x.round(precision: 2)
            let rotationY = data.rotationRate.y.round(precision: 2)
            let rotationZ = data.rotationRate.z.round(precision: 2)
            self.rotationRateLabel.text = "x: \(rotationX), y: \(rotationY), z: \(rotationZ)"
            
            let pitch = data.attitude.pitch.round(precision: 2)
            let roll = data.attitude.roll.round(precision: 2)
            let yaw = data.attitude.yaw.round(precision: 2)
            self.attitudeLabel.text = "Pitch: \(pitch), roll: \(roll), yaw: \(yaw)"
            
            let magneticX = data.magneticField.field.x
            let magneticY = data.magneticField.field.y
            let magneticZ = data.magneticField.field.z
            self.magneticFieldLabel.text = "x: \(magneticX), y: \(magneticY), z: \(magneticZ)"
        }
    }
}
