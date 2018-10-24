//
//  Toast.swift
//  Seebo Project 
//
//  Created by Admin on 10/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

class ToastView
{
    class func showToast(message:String,view:UIView)
    {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300,  height : 35))
        toastLabel.backgroundColor = UIColor(white: 0.85, alpha: 1)
        toastLabel.textColor = UIColor.black
        toastLabel.textAlignment = NSTextAlignment.center;
        view.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 8.0, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            toastLabel.alpha = 0.0
            
        })
    }
}
