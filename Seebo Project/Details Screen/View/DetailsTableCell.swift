//
//  DetailsTableCellTableViewCell.swift
//  Seebo Project 
//
//  Created by Admin on 9/20/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class DetailsTableCell: UITableViewCell {

    @IBOutlet weak var title_details: UILabel!
    @IBOutlet weak var value_details: UILabel!
    
    func configure(attributes:Attribute) {
        
            title_details.text = attributes.attribute_title
            value_details.text = attributes.subattribute_title
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
