//
//  ReviewCell.swift
//  Seebo Project 
//
//  Created by Admin on 9/20/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SDWebImage

class ReviewCell: UITableViewCell {

    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var reviewstr: UITextView!
    
    func configure(review:Review) {
        username.text = review.user?.username
        reviewstr.text = review.review_str
        time.text = review.created
        let iconurl = URL(string: (review.user?.image)!)
        userimage.sd_setImage(with: iconurl,placeholderImage:#imageLiteral(resourceName: "dress"))
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
