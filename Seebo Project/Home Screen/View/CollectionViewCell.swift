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
    @IBOutlet weak var checkmark: UIImageView!
    @IBOutlet weak var titelAdvert: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var titleCat: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var imagee: UIImageView!
   // @IBOutlet weak var model1: UILabel!
   // @IBOutlet weak var model2: UILabel!
    func configure(item:Item)
    {
        if let imagedescrib = item.imageDescription{
        describtion.text = imagedescrib
        }
        if let imagename = item.imagename {
        image.image = UIImage(named: imagename)
        }
    }
    func configure2(advertis:advertisment) {
        
        titelAdvert.text = advertis.adv_title
        titelAdvert.textColor = UIColor(red: 0.1569, green: 0.2314, blue: 0.5333, alpha: 1.0)
        titleCat.text = "\(advertis.category_title!)/\(advertis.subCategory_title!)"
        titleCat.textColor = UIColor(red: 0.4392, green: 0.4392, blue: 0.4392, alpha: 1.0)
        distance.text = "\(advertis.distance!)m"
        price.text = "EGP \(advertis.price!)"
        price.textColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0)
        distance.textColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0)
        let iconurl = URL(string: advertis.mainImage!)
        imagee.sd_setImage(with: iconurl,placeholderImage:#imageLiteral(resourceName: "home"))
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        model1.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
//        model1.backgroundColor = UIColor(red: 0.1569, green: 0.2314, blue: 0.5333, alpha: 1.0)
//        model1.textColor = UIColor.white
//        model1.text = "New"
//        model1.layer.masksToBounds = true
//        model1.layer.cornerRadius = 10
//        model2.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
//        model2.backgroundColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0)
//        model2.textColor = UIColor.white
//        model2.text = "Feature"
//        model2.layer.masksToBounds = true
//        model2.layer.cornerRadius = 10
//    }
}
