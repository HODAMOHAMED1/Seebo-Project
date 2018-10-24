//
//  TextFieldUnderLine.swift
//  Seebo Project 
//
//  Created by Admin on 10/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

extension UITextField
 {
    
     func configure () {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y:self.frame.height - 1), size: CGSize(width:self.frame.width, height:  1))
        bottomLine.backgroundColor = UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 1.0).cgColor
        self.borderStyle = UITextBorderStyle.none
        self.layer.addSublayer(bottomLine)
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.9922, green: 0.7529, blue: 0.0863, alpha: 0.5)])
    }
    func textFieldWithIcon(image:UIImage){
        self.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.image!.size.width + 13, height: imageView.image!.size.height)
        imageView.contentMode = UIViewContentMode.left
        self.leftView = imageView
    }
}
