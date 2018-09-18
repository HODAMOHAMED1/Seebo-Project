//
//  CollectionViewCell.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var describtion: UILabel!
    
    func configure(item:Item)
    {
        if let imagedescrib = item.imageDescription{
        describtion.text = imagedescrib
        }
        if let imagename = item.imagename {
        image.image = UIImage(named: imagename)
        }
    }
}
