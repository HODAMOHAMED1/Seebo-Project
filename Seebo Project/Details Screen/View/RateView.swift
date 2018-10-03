//
//  RateView.swift
//  Seebo Project 
//
//  Created by Admin on 9/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

@IBDesignable
class RateView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var str1: UIButton!
    @IBOutlet weak var str2: UIButton!
    @IBOutlet weak var str3: UIButton!
    @IBOutlet weak var str4: UIButton!
    @IBOutlet weak var str5: UIButton!
    @IBInspectable var enable :Bool = false
    var stars : [UIButton]!
    
    override func layoutSubviews() {
      str1.isEnabled = enable
      str2.isEnabled = enable
      str3.isEnabled = enable
      str4.isEnabled = enable
      str5.isEnabled = enable
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
        let nib = UINib(nibName: "RateView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    func configure (flag:Int,rate:Int){
         stars = [str1,str2,str3,str4,str5]
        if (flag == 0) {
            for i in 0...rate-1 {
                stars[i].setImage(#imageLiteral(resourceName: "gold_star"), for: .normal)
            }
        }
    }
}
