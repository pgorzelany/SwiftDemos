//
//  LocationUtils.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 04/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

//
//  LocationUtils.swift
//  Hypeit
//
//  Created by PiotrGorzelanyMac on 11/02/16.
//  Copyright © 2016 Rst-It. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

/**
 * Helper class for getting the current location and adress of the phone.
 * When initialized the location manager will try to obtain the current location of the phone immediately.
 * The manager will then constantly monitor the current location and will react to changes.
 */
class LocationManager: NSObject {
    
    enum State {
        
        case Initial
        
        /** Location manager is trying to update location */
        case FetchingLocation
        
        /** Location manager cannot obtain current location */
        case Error(NSError)
        
        /** Location manager has obtained at least one current location */
        case Success
        
    }
    
    struct Route {
        
        /** Estimated distance in meters between origin and destination */
        let estimatedDistance: Double
        
        /** Estimated travel time in seconds between origin and destination */
        let estimatedTime: Double
        
        /** The path from the origin to destination */
        let path: GMSPath
        
    }
    
    // MARK: Shared instance
    
    static let sharedInstance = LocationManager()
    
    // MARK: Properties
    
    private let disposeBag = DisposeBag()
    
    lazy private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest //If batery life becomes an issue we can play with this parameter
        manager.activityType = CLActivityType.Fitness
        manager.pausesLocationUpdatesAutomatically = true
        manager.distanceFilter = 10.0
        manager.delegate = self
        return manager
    }()
    
    let state = Variable<LocationManager.State>(.Initial)
    
    /** User last known location or nil if location could not be obtained. */
    let currentLocation = Variable<CLLocation?>(nil)
    
    /** User last known address location or nil if address could not be obtained */
    let currentAddress = Variable<GMSAddress?>(nil)
    
    private let authorizationStatus = Variable<CLAuthorizationStatus>(CLLocationManager.authorizationStatus())
    
    // MARK: Initializers
    
    override init() {
        super.init()
        
        self.setupBindings()
        
    }
    
    // MARK: Methods
    
    private func setupBindings() {
        
        authorizationStatus.asObservable()
            .bindNext { [unowned self](authorizationStatus) -> Void in
                
                guard CLLocationManager.locationServicesEnabled() else {
                    self.state.value = .Error(ElGrocerError.locationServicesDisabledError())
                    return
                }
                
                switch authorizationStatus {
                case .AuthorizedWhenInUse, .AuthorizedAlways:
                    self.fetchCurrentLocation()
                case .NotDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                case .Restricted:
                    self.state.value = .Error(ElGrocerError.locationServicesAuthorizationError())
                case .Denied:
                    self.state.value = .Error(ElGrocerError.locationServicesAuthorizationError())
                }
                
            }.addDisposableTo(disposeBag)
        
        
        currentLocation.asObservable().bindNext { (location) in
            
            guard let location = location else {return}
            
            let coordinate = location.coordinate
            
            GMSGeocoder().reverseGeocodeCoordinate(coordinate) { (geocodingResponse, error) -> Void in
                
                guard let geocodingResponse = geocodingResponse else {return}
                guard let result = geocodingResponse.firstResult() else {return}
                self.currentAddress.value = result
                
            }
            
            }.addDisposableTo(disposeBag)
        
    }
    
    /** Uses Google Maps reverse geocoding to get an address from a location on map */
    func getAddressForLocation(location: CLLocation, successHandler: (address: GMSAddress) -> Void, errorHandler: (error: NSError?) -> Void) {
        
        GMSGeocoder().reverseGeocodeCoordinate(location.coordinate) { (geocodingResponse, error) -> Void in
            
            guard let geocodingResponse = geocodingResponse else {
                if let error = error {
                    errorHandler(error: error)
                }
                return
            }
            
            guard let result = geocodingResponse.firstResult() else {
                errorHandler(error: nil)
                return
            }
            
            successHandler(address: result)
            
        }
        
    }
    
    private func fetchCurrentLocation() {
        
        guard authorizationStatus.value == .AuthorizedWhenInUse && CLLocationManager.locationServicesEnabled() == true else { return }
        
        state.value = .FetchingLocation
        self.locationManager.startUpdatingLocation()
        
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        authorizationStatus.value = status
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLocation = locations.last {
            
            self.currentLocation.value = currentLocation
            self.state.value = .Success
            
        }
        
    }
    
}

