//
//  CardViewDetails.swift
//  Seebo Project 
//
//  Created by Admin on 9/19/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

@IBDesignable
class CardViewDetails: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var item_name: UILabel!
    @IBOutlet weak var item_type: UILabel!
    @IBOutlet weak var tradein: UILabel!
    @IBOutlet weak var firmprice: UILabel!
    @IBInspectable var cornerRadius: CGFloat = 20
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        view.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowPath = shadowPath.cgPath
        view.frame = bounds
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = shadowColor?.cgColor
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        view = loadViewFromNib()
        addSubview(view)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = loadViewFromNib()
        addSubview(view)
    }
    func loadViewFromNib()->UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CardViewDetails", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    func configure(adverit:advertisment) {
        price.text = "EGP \(adverit.price!)"
        item_name.text = adverit.adv_title!
        item_type.text = "\(adverit.brand_title!)/\(adverit.model_title!)"
        tradein.text = "\(adverit.trade!)"
        firmprice.text = "\(adverit.firmPrice!)"
        
    }
}
