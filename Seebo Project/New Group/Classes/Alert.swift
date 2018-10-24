//
//  Alert.swift
//  Seebo Project 
//
//  Created by Admin on 10/4/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Alert {
    
    //MARK:- LocationAlert
    class func showConnectionAlert (title:String,message:String,view:UIViewController,splash:Int){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "TRY AGAIN", style: UIAlertActionStyle.cancel, handler: {action in
            if splash == 0 {
            (view as! SplashViewController).viewWillAppear(true)
            }else if splash == 1{
                (view as! LoginScreenViewController).accessDataToHome()
            }else{
                (view as! FBRegisterViewController).accessDataToHome()
            }
        }))
        view.present(alert, animated: true, completion: nil)
    }
    
    class func showGpsAlert (title:String,message:String,view:UIViewController,splash:Int){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: UIAlertActionStyle.default, handler: {(_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                    if splash == 0 {
                    (view as! SplashViewController).accessLocation()
                    }else{
                    (view as! LoginScreenViewController).accessLocation()
                    }
                })
            }}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {action in
            var loc = CLLocation(latitude: 29.315654, longitude: 28.46415)
             if splash == 0 {
            (view as! SplashViewController).sendLocation(location:loc )
             }else{
                (view as! LoginScreenViewController).sendLocation(location:loc )
            }
        }))
        view.present(alert, animated: true, completion: nil)
    }
    //MARK:- GerneralAlert
    class func alert(view:UIViewController,title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler:nil))
        view.present(alert, animated: true, completion: nil)
    }
    //MARK:- InvalidEmailOrPassword
    class func invalidEmailOrPassword(view:UIViewController){
        let alert = UIAlertController(title: "Invalid", message: "Invalid Email Or Password", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler:nil))
        view.present(alert, animated: true, completion: nil)
    }
}
