//
//  CustomCollectionViewCell.swift
//  SwiftDemos
//
//  Created by Piotr Gorzelany on 12/05/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBAction func buttonTouched(sender: UIButton) {
        
        print("Cell button touched")
    }
    
    
}
