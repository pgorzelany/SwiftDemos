//
//  BasicCollectionViewController.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 08/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class BasicCollectionViewController: UIViewController, StoryboardInstantiable {

    // MARK: StoryboardInstantiable
    
    static let storyboardId = "BasicCollectionViewController"
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    // MARK: Initializers
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Basic Collection View"
    }
    
    // MARK: Actions
    
    // MARK: Support
    
    // MARK: Data
    
    // MARK: Appearance

}

extension BasicCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "basicCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "basicHeader", for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (indexPath as NSIndexPath).row % 3 == 0 ? self.collectionView.frame.size.width : self.collectionView.frame.size.width / 2.0
        let height: CGFloat = 60.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 50, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("selected item at indexPath: \(indexPath)")
    }
    
}
