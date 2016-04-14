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
    let controller: UIViewController?
    
}

class TOKViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: StoryboardInstantiable
    
    static let storyboardId = "TOK"
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    let tableViewModel = [
        TOKSection(hader: "Notifications", rows: [
            TOKRow(title: "Local Notifications", controller: nil),
            TOKRow(title: "Remote Notifications", controller: nil)
            ]
        ),
        TOKSection(hader: "Gesture Recognizers", rows: [
            TOKRow(title: "Gesture Recognizers", controller: nil)
            ]
        ),
        TOKSection(hader: "View Animations", rows: [
            TOKRow(title: "View Dragging", controller: nil),
            TOKRow(title: "Drawing", controller: nil),
            TOKRow(title: "Animating Constraints", controller: nil),
            TOKRow(title: "Affine Transforms", controller: nil),
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
        TOKSection(hader: "Mapkit", rows: []),
        TOKSection(hader: "Core Motion", rows: []),
        TOKSection(hader: "AV Foundation", rows: []),
        TOKSection(hader: "SpriteKit", rows: [
            ]
        )
    ]
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Table of Content"
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: Actions
    
    // MARK: Data
    
    // MARK: Appearance

}

extension TOKViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.tableViewModel.count
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableViewModel[section].rows.count
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.tableViewModel[section].hader
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return self.tableViewModel[section].footer
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tokCell")!
        cell.textLabel?.text = "\(self.tableViewModel[indexPath.section].rows[indexPath.row].title)"
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = self.tableViewModel[indexPath.section].rows[indexPath.row]
        
        let controller = row.controller ?? UnimplementedViewController.instantiateFromStoryboard()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
