//
//  TabBarView.swift
//  
//
//  Created by Admin on 10/15/18.
//

import UIKit

class TabBarView: UITabBarController {

    let button = UIButton.init(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.clipsToBounds = true
        self.tabBar.backgroundImage = UIImage()
        let bgView: UIImageView = UIImageView(image: UIImage(named: "tabBackground"))
        bgView.frame = CGRect(x: 0, y: self.tabBar.frame.minY-40 , width: self.tabBar.frame.width, height: self.tabBar.frame.height*1.5)
        self.view.insertSubview(bgView, belowSubview: self.tabBar)
        self.tabBar.sendSubview(toBack: bgView)
        let icon = UIImage(named:"center")
        button.setImage(icon, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.insertSubview(button, aboveSubview: self.tabBar)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // safe place to set the frame of button manually
        button.frame = CGRect.init(x: self.tabBar.center.x - 45, y: self.view.bounds.height - 90, width: 90, height: 90)
    }
    @objc func buttonAction(sender: UIButton!) {
        self.selectedViewController = self.viewControllers?[2]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
