//
//  UserContact.swift
//  Seebo Project 
//
//  Created by Admin on 9/20/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

@IBDesignable
class UserContact: UIView {
    

    @IBOutlet var view: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userproducts: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 5
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.2
    
    @IBAction func contact(_ sender: Any) {
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }
    func loadViewFromNib()->UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UserContact", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    func configure(user:User) {
        username.text = user.username
        let iconurl = URL(string: (user.image)!)
        userimage.sd_setImage(with: iconurl,placeholderImage:#imageLiteral(resourceName: "jacket"))
    }

}
