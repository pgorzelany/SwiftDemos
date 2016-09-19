//
//  LocationUtils.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 04/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
//import RxCocoa

/**
 * Helper class for getting the current location and adress of the phone.
 * When initialized the location manager will try to obtain the current location of the phone immediately.
 * The manager will then constantly monitor the current location and will react to changes.
 */
class LocationManager: NSObject {
    
    enum State {
        
        case initial
        
        /** Location manager is trying to update location */
        case fetchingLocation
        
        /** Location manager cannot obtain current location */
        case error(NSError)
        
        /** Location manager has obtained at least one current location */
        case success
        
    }
    
    // MARK: Shared instance
    
    static let sharedInstance = LocationManager()
    
    // MARK: Properties
    
    fileprivate let disposeBag = DisposeBag()
    
    lazy fileprivate var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest //If batery life becomes an issue we can play with this parameter
        manager.activityType = CLActivityType.fitness
        manager.pausesLocationUpdatesAutomatically = true
        manager.distanceFilter = 10.0
        manager.delegate = self
        return manager
    }()
    
    let state = Variable<LocationManager.State>(.initial)
    
    /** User last known location or nil if location could not be obtained. */
    let currentLocation = Variable<CLLocation?>(nil)
    
    fileprivate let authorizationStatus = Variable<CLAuthorizationStatus>(CLLocationManager.authorizationStatus())
    
    // MARK: Initializers
    
    override init() {
        super.init()
        
        self.setupBindings()
        
    }
    
    // MARK: Methods
    
    fileprivate func setupBindings() {
        
        authorizationStatus.asObservable()
            .subscribe(onNext: { [unowned self](status) in
                guard CLLocationManager.locationServicesEnabled() else {
                    return
                }
                
                switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    self.fetchCurrentLocation()
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                case .restricted:
                    break
                case .denied:
                    break
                }

            }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        
        
    }
    
    fileprivate func fetchCurrentLocation() {
        
        guard authorizationStatus.value == .authorizedWhenInUse && CLLocationManager.locationServicesEnabled() == true else { return }
        
        state.value = .fetchingLocation
        self.locationManager.startUpdatingLocation()
        
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        authorizationStatus.value = status
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLocation = locations.last {
            
            self.currentLocation.value = currentLocation
            self.state.value = .success
            
        }
        
    }
    
}

