//
//  Thanks ViewController.swift
//  Seebo Project 
//
//  Created by Admin on 10/22/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class Thanks_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneBtn(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let termsController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! LoginScreenViewController
        navigationController?.pushViewController(termsController, animated: true)
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
