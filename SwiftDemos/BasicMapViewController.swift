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
        case .Hybrid: return "Hybrid"
        case .HybridFlyover: return "HybridFlyover"
        case .Satellite: return "Satellite"
        case .SatelliteFlyover: return "SatelliteFlyover"
        case .Standard: return "Standard"
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
    
    let mapTypes: [MKMapType] = [.Standard, .Satellite, .Hybrid]
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Basic Map"
        
        self.configureSegmentControl()
        self.configureMapView()
    }
    
    // MARK: Actions
    
    @IBAction func segmentControlValueChanged(sender: UISegmentedControl) {
        
        self.mapView.mapType = mapTypes[sender.selectedSegmentIndex]
    }
    
    // MARK: Support
    
    private func configureMapView() {
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.mapType = .Standard
    }
    
    // MARK: Data
    
    // MARK: Appearance
    
    private func configureSegmentControl() {
        
        self.segmentControl.removeAllSegments()
        
        for (index, type) in mapTypes.enumerate() {
            
            self.segmentControl.insertSegmentWithTitle(type.description, atIndex: index, animated: false)
        }
        
        self.segmentControl.selectedSegmentIndex = 0
    }

}

extension BasicMapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        print("User location is: \(userLocation)")
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        
        print("Changed drag state of annotated view from \(oldState) to \(newState)")
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        print("Region was changed")
        print("Center coordinates are now: \(self.mapView.centerCoordinate)")
    }
}
