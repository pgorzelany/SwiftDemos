//
//  TOKViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 14/04/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

struct TOKSection {
    
    let hader: String
    let footer: String? = nil
    let rows: [TOKRow]
    
}

struct TOKRow {
    
    let title: String
    let controller: StoryboardInstantiable.Type?
    
}

class TOKViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: StoryboardInstantiable
    
    static let storyboardId = "TOK"
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    let tableViewModel = [
        TOKSection(hader: "Core Graphics", rows: [
            TOKRow(title: "Affine Transforms", controller: AffineTransformViewController.self),
            TOKRow(title: "Affine Transform Navigation Controller", controller: TransformNavigationController.self),
            TOKRow(title: "Image Overlay Drawing", controller: ContextDrawingViewController.self),
            TOKRow(title: "Canvas Drawing", controller: CanvasViewController.self)
            ]),
        TOKSection(hader: "UIViews", rows: [
            TOKRow(title: "ScrollView", controller: ProgrammaticScrollViewController.self)
            ]),
        TOKSection(hader: "Custom UIViews", rows: [
            TOKRow(title: "Color slider", controller: ColorSliderViewController.self)
            ]),
        TOKSection(hader: "UICollectionView", rows: [
            TOKRow(title: "Basic CollectionView", controller: BasicCollectionViewController.self),
            TOKRow(title: "Custom CollectionView Layout", controller: CustomCollectionViewLayoutViewController.self)
            ]),
        TOKSection(hader: "Notifications", rows: [
            TOKRow(title: "Local Notifications", controller: LocalNotificationsViewController.self),
            TOKRow(title: "Remote Notifications", controller: nil)
            ]
        ),
        TOKSection(hader: "Gesture Recognizers", rows: [
            TOKRow(title: "Gesture Recognizers", controller: GestureRecognizersViewController.self),
            TOKRow(title: "Manipulable View", controller: ManipulableViewController.self)
            ]
        ),
        TOKSection(hader: "View Animations", rows: [
            TOKRow(title: "View Controller Custom Transitions", controller: MasterTransitionViewController.self),
            TOKRow(title: "View Dragging", controller: ViewDraggingViewController.self),
            TOKRow(title: "Drawing", controller: nil),
            TOKRow(title: "Animating Constraints", controller: nil),
            ]
        ),
        TOKSection(hader: "Core Animation", rows: [
            TOKRow(title: "Position", controller: nil),
            TOKRow(title: "Path", controller: nil),
            TOKRow(title: "Animation Groups", controller: nil)
            ]
        ),
        TOKSection(hader: "UIKit Dynamics", rows: [
            ]
        ),
        TOKSection(hader: "Mapkit", rows: [
            TOKRow(title: "Basic Map", controller: BasicMapViewController.self),
            TOKRow(title: "Geocoding", controller: GeocodingViewController.self)
            ]),
        TOKSection(hader: "Core Motion", rows: []),
        TOKSection(hader: "AVFoundation, GPUImage", rows: [
            TOKRow(title: "GPUImage swipable video filters", controller: SwipableVideoFilterViewController.self),
            TOKRow(title: "QRCode scanner", controller: QRCodeViewController.self),
            TOKRow(title: "Face Recognition", controller: FaceRecognitionViewController.self),
            TOKRow(title: "HTTP Live Streaming", controller: HLSViewController.self)
            ]),
        TOKSection(hader: "SpriteKit", rows: [
            ]
        )
    ]
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "TOC"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.addSearchBar()
    }
    
    // MARK: Actions
    
    // MARK: Data
    
    // MARK: Appearance
    
    fileprivate func addSearchBar() {
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 1, height: 35))
        searchBar.placeholder = "Search for demo"
        searchBar.delegate = self
        self.tableView.tableHeaderView = searchBar
        
    }

}

// MARK: Tableview deletage and data source

extension TOKViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.tableViewModel.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableViewModel[section].rows.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.tableViewModel[section].hader
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return self.tableViewModel[section].footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "tokCell")!
        cell.textLabel?.text = "\(self.tableViewModel[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row].title)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = self.tableViewModel[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row]
        
        let controller = row.controller?.instantiateFromStoryboard() ?? UnimplementedViewController.instantiateFromStoryboard()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

// MARK: Searchbar delegate

extension TOKViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("Searched text is: \(searchText)")
        
    }
    
}
