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
    
    // MARK: Properties
    
    private let motionManager = CMMotionManager()
    private var motionQueue: OperationQueue!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
    }
    
    // MARK: Configuration
    
    private func configureController() {
        configureOperationQueue()
        configureMotionManager()
    }
    
    private func configureOperationQueue() {
        motionQueue = OperationQueue()
        motionQueue.maxConcurrentOperationCount = 1
        motionQueue.qualityOfService = .userInteractive
        
    }
    
    private func configureMotionManager() {
        motionManager.deviceMotionUpdateInterval = 0.5
    }
    
    // MARK: Actions
    
    @IBAction private func startMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: handleDeviceMotionUpdate)
        }
    }
    
    @IBAction private func stopMotionManager() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    private func handleDeviceMotionUpdate(data: CMDeviceMotion?, error: Error?) {
        guard let data = data else {
            return
        }
        
        print(data.gravity)
        gravityLabel.text = "x: \(data.gravity.x), y: \(data.gravity.y), z: \(data.gravity.z)"
    }
}
