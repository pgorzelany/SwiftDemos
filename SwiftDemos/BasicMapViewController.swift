//
//  BasicMapViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 26/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import MapKit

class BasicMapViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "BasicMap"
    
    // MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Properties
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Basic Map"
        
        self.configureMapView()
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    private func configureMapView() {
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.mapType = .Standard
    }
    
    // MARK: Data
    
    // MARK: Appearance

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