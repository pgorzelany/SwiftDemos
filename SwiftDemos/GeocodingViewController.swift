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
        
    }
    
    
    // MARK: Appearance

}

extension GeocodingViewController: UITextFieldDelegate {
    
    
    
}
