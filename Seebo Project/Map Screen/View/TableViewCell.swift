//
//  TableViewCell.swift
//  Seebo Project 
//
//  Created by Admin on 9/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titelAdvert: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var titleCat: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var model1: UILabel!
    @IBOutlet weak var model2: UILabel!
    
    func configure(advertis:advertisment) {
        
        titelAdvert.text = advertis.adv_title
        titelAdvert.textColor = UIColor(red: 0.1569, green: 0.2314, blue: 0.5333, alpha: 1.0)
        titleCat.text = "\(advertis.category_title!)/\(advertis.subCategory_title!)"
        titleCat.textColor = UIColor(red: 0.4392, green: 0.4392, blue: 0.4392, alpha: 1.0)
        distance.text = "\(advertis.distance!)m"
        price.text = "EGP \(advertis.price!)"
        price.textColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0)
        distance.textColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0)
        let iconurl = URL(string: advertis.mainImage!)
        imagee.sd_setImage(with: iconurl,placeholderImage:#imageLiteral(resourceName: "dress"))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        model1.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        model1.backgroundColor = UIColor(red: 0.1569, green: 0.2314, blue: 0.5333, alpha: 1.0)
        model1.textColor = UIColor.white
        model1.text = "New"
        model1.layer.masksToBounds = true
        model1.layer.cornerRadius = 10
        model2.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        model2.backgroundColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0)
        model2.textColor = UIColor.white
        model2.text = "Feature"
        model2.layer.masksToBounds = true
        model2.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
