//
//  CustomCollectionViewLayout.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 12/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {
    
    private var smallCellSize: CGSize!
    private var avatarCellSize: CGSize!
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    
    override func prepareLayout() {
        super.prepareLayout()
        print(#function)
        
        self.avatarCellSize = CGSize(width: 200, height: 200)
        self.smallCellSize = CGSize(width: 40, height: 40)
        
        let numberOfItems = self.collectionView!.numberOfItemsInSection(0)
        
        for i in 0..<numberOfItems {
            
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            if indexPath.row == 0 {
                
                attribute.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: avatarCellSize)
                
            } else {
                
                attribute.frame = CGRect(origin: CGPoint(x: avatarCellSize.width + 10, y: (smallCellSize.height  + 10) * CGFloat((indexPath.row - 1))), size: smallCellSize)
                
            }
            
            attributesCache.append(attribute)
            
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        print(#function)
        
//        let width = CGRectGetWidth(collectionView!.frame)
//        let height: CGFloat = 150
        
        return CGSize(width: collectionView!.frame.size.width, height: CGFloat(collectionView!.numberOfItemsInSection(0)) * smallCellSize.height)
        
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print(#function)
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in self.attributesCache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
        
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        print(#function)
        
        return attributesCache[indexPath.row]
        
    }
    
}
