//
//  CustomCollectionViewLayoutViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 12/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class CustomCollectionViewLayoutViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "CustomCollectionViewLayout"
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private let collectionViewCellReuseIdentifier = "customCell"
    
    /** This cell is being set, when the user starts to move one of the cells by a long press gesture */
    private var movedCell: CustomCollectionViewCell? {
        didSet {
            self.movedCellSnapshotView = movedCell?.snapshotViewAfterScreenUpdates(true)
        }
    }
    
    private var movedCellSnapshotView: UIView? {
        willSet {
            if newValue == nil {
                movedCellSnapshotView?.removeFromSuperview()
            }
        }
    }
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Custom CollectionViewLayout"
        self.configureCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    
    // MARK: Actions
    
    @IBAction func moveCellButtonTouched(sender: UIButton) {
        
        let fromIndexPath = NSIndexPath(forItem: 4, inSection: 0)
        let toIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        
        self.collectionView.moveItemAtIndexPath(fromIndexPath, toIndexPath: toIndexPath)
        
    }
    
    // MARK: Support
    
    private func configureCollectionView() {
        
        let cellNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(cellNib, forCellWithReuseIdentifier: self.collectionViewCellReuseIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized))
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
        
    }
    
    func longPressGestureRecognized(gesture: UILongPressGestureRecognizer) {
        print(#function)
        
        
        switch gesture.state {
            
        case .Began:
            print("Longpress begin")
            
            self.movedCell = self.getCellForLongPressGesture(gesture)
            if let snapshot =  self.movedCellSnapshotView {
                snapshot.center = gesture.locationInView(self.view)
                self.view.addSubview(snapshot)
            }
            
        case .Changed:
            print("Longpress changed")
            
            guard let movedCell = self.movedCell, snapshot = self.movedCellSnapshotView else {return}
            
            snapshot.center = gesture.locationInView(self.view)
            
            if let moveToIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) {
                
                if let originalIndexPath = self.collectionView.indexPathForCell(movedCell) where moveToIndexPath != originalIndexPath {
                    
                    self.collectionView.moveItemAtIndexPath(originalIndexPath, toIndexPath: moveToIndexPath)
                    
                }
                
            }
            
        case .Ended:
            print("Longpress ended")
            
            self.movedCell = nil
            
        case .Cancelled:
            print("Longpress canceled")
            
            self.movedCell = nil
            
        default: break
            
        }
        
    }
    
    private func getCellForLongPressGesture(gesture: UILongPressGestureRecognizer) -> CustomCollectionViewCell? {
        
        if let indexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) {
            
            if let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as? CustomCollectionViewCell {
                print("Got cell at row \(indexPath.row)")
                return cell
            }
            
        }
        
        return nil
    }
    
    // MARK: Data
    
    // MARK: Appearance
    
    private func resizeCell(cell: CustomCollectionViewCell) {
        
        
        
    }

}

extension CustomCollectionViewLayoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.collectionViewCellReuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.titleLabel.text = "\(indexPath.row)"
        return cell
        
    }
    
    
    
}
