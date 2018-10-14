//
//  NavigationBarView.swift
//  Seebo Project 
//
//  Created by Admin on 9/25/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

@IBDesignable
class NavigationBarView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Back: UIButton!
    @IBInspectable var Back_hidden:Bool = false
    @IBInspectable var Title_text:String = "Search"
    
    @IBAction func backAction(_ sender: UIButton) {
    }
    override func layoutSubviews() {
       Back.isHidden = Back_hidden
       Title.text = Title_text
    }
    override init(frame:CGRect){
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
        let nib = UINib(nibName: "NavigationBarView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
