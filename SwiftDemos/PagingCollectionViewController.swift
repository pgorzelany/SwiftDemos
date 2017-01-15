//
//  PagingCollectionViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 15/01/2017.
//  Copyright © 2017 Piotr Gorzelany. All rights reserved.
//

import UIKit

class PagingCollectionViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "PagingCollectionViewDemo"
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: Properties
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureController()
    }
    
    // MARK: Configuration
    
    private func configureController() {
        let nib = UINib(nibName: "PagingCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "PagingCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentSize = CGSize(width: 400, height: 100)
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    // MARK: Data
    
    // MARK: Appearance

}

extension PagingCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagingCollectionViewCell", for: indexPath) as! PagingCollectionViewCell
        cell.titleLabel.text = "item \(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("cell has superview: \(cell.superview != nil)")
        print("cell superview is collectionView \(cell.superview! is UICollectionView)")
        cell.isHidden = false
        cell.contentView.isHidden = false
    }
}
