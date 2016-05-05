//
//  GeocodingViewController.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 04/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit
import MapKit

class GeocodingViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "Geocoding"
    
    // MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressTextField: UITextField!
    
    // MARK: Properties
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Geocoding"
        self.configureController()
    }
    
    
    // MARK: Actions
    
    
    // MARK: Helpers
    
    private func configureController() {
        
        addressTextField.delegate = self
        self.mapView.delegate = self
        
    }
    
    
    // MARK: Appearance

}

// MARK: UITextFieldDelegate
extension GeocodingViewController: UITextFieldDelegate {
    
    
    
}

// MARK: MKMapViewDelegate
extension GeocodingViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        print(#function)
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        print(#function)
        
    }
    
}
