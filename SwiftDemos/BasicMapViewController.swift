//
//  BasicMapViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 26/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import MapKit

extension MKMapType: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
        case .hybrid: return "Hybrid"
        case .hybridFlyover: return "HybridFlyover"
        case .satellite: return "Satellite"
        case .satelliteFlyover: return "SatelliteFlyover"
        case .standard: return "Standard"
        }
    }
}

class BasicMapViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "BasicMap"
    
    // MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: Properties
    
    let mapTypes: [MKMapType] = [.standard, .satellite, .hybrid]
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Basic Map"
        
        self.configureSegmentControl()
        self.configureMapView()
    }
    
    // MARK: Actions
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
        self.mapView.mapType = mapTypes[sender.selectedSegmentIndex]
    }
    
    // MARK: Support
    
    fileprivate func configureMapView() {
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.mapType = .standard
    }
    
    // MARK: Data
    
    // MARK: Appearance
    
    fileprivate func configureSegmentControl() {
        
        self.segmentControl.removeAllSegments()
        
        for (index, type) in mapTypes.enumerated() {
            
            self.segmentControl.insertSegment(withTitle: type.description, at: index, animated: false)
        }
        
        self.segmentControl.selectedSegmentIndex = 0
    }

}

extension BasicMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        print("User location is: \(userLocation)")
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        
        print("Changed drag state of annotated view from \(oldState) to \(newState)")
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        print("Region was changed")
        print("Center coordinates are now: \(self.mapView.centerCoordinate)")
    }
}
