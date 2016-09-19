//
//  CustomCollectionViewLayout.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 12/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {
    
    fileprivate var smallCellSize: CGSize!
    fileprivate var avatarCellSize: CGSize!
    
    fileprivate var attributesCache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        print(#function)
        
        self.avatarCellSize = CGSize(width: 200, height: 200)
        self.smallCellSize = CGSize(width: 40, height: 40)
        
        let numberOfItems = self.collectionView!.numberOfItems(inSection: 0)
        
        for i in 0..<numberOfItems {
            
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            if (indexPath as NSIndexPath).row == 0 {
                
                attribute.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: avatarCellSize)
                
            } else {
                
                attribute.frame = CGRect(origin: CGPoint(x: avatarCellSize.width + 10, y: (smallCellSize.height  + 10) * CGFloat(((indexPath as NSIndexPath).row - 1))), size: smallCellSize)
                
            }
            
            attributesCache.append(attribute)
            
        }
    }
    
    override var collectionViewContentSize : CGSize {
        print(#function)
        
//        let width = CGRectGetWidth(collectionView!.frame)
//        let height: CGFloat = 150
        
        return CGSize(width: collectionView!.frame.size.width, height: CGFloat(collectionView!.numberOfItems(inSection: 0)) * smallCellSize.height)
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print(#function)
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in self.attributesCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print(#function)
        
        return attributesCache[(indexPath as NSIndexPath).row]
        
    }
    
}
