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
    
    fileprivate let collectionViewCellReuseIdentifier = "customCell"
    
    /** This cell is being set, when the user starts to move one of the cells by a long press gesture */
    fileprivate var movedCell: CustomCollectionViewCell? {
        didSet {
            self.movedCellSnapshotView = movedCell?.snapshotView(afterScreenUpdates: true)
        }
    }
    
    fileprivate var movedCellSnapshotView: UIView? {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    
    // MARK: Actions
    
    @IBAction func moveCellButtonTouched(_ sender: UIButton) {
        
        let fromIndexPath = IndexPath(item: 4, section: 0)
        let toIndexPath = IndexPath(item: 0, section: 0)
        
        self.collectionView.moveItem(at: fromIndexPath, to: toIndexPath)
        
    }
    
    // MARK: Support
    
    fileprivate func configureCollectionView() {
        
        let cellNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: self.collectionViewCellReuseIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized))
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
        
    }
    
    @objc func longPressGestureRecognized(_ gesture: UILongPressGestureRecognizer) {
        print(#function)
        
        
        switch gesture.state {
            
        case .began:
            print("Longpress begin")
            
            self.movedCell = self.getCellForLongPressGesture(gesture)
            if let snapshot =  self.movedCellSnapshotView {
                snapshot.center = gesture.location(in: self.view)
                self.view.addSubview(snapshot)
            }
            
        case .changed:
            print("Longpress changed")
            
            guard let movedCell = self.movedCell, let snapshot = self.movedCellSnapshotView else {return}
            
            snapshot.center = gesture.location(in: self.view)
            
            if let moveToIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) {
                
                if let originalIndexPath = self.collectionView.indexPath(for: movedCell) , moveToIndexPath != originalIndexPath {
                    
                    self.collectionView.moveItem(at: originalIndexPath, to: moveToIndexPath)
                    
                }
                
            }
            
        case .ended:
            print("Longpress ended")
            
            self.movedCell = nil
            
        case .cancelled:
            print("Longpress canceled")
            
            self.movedCell = nil
            
        default: break
            
        }
        
    }
    
    fileprivate func getCellForLongPressGesture(_ gesture: UILongPressGestureRecognizer) -> CustomCollectionViewCell? {
        
        if let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) {
            
            if let cell = self.collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
                print("Got cell at row \((indexPath as NSIndexPath).row)")
                return cell
            }
            
        }
        
        return nil
    }
    
    // MARK: Data
    
    // MARK: Appearance
    
    fileprivate func resizeCell(_ cell: CustomCollectionViewCell) {
        
        
        
    }

}

extension CustomCollectionViewLayoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellReuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.titleLabel.text = "\((indexPath as NSIndexPath).row)"
        return cell
        
    }
    
    
    
}
