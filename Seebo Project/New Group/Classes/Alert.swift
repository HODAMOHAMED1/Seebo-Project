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
    
    class func showConnectionAlert (title:String,message:String,view:SplashViewController){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "TRY AGAIN", style: UIAlertActionStyle.cancel, handler: {action in view.viewWillAppear(true)}))
        view.present(alert, animated: true, completion: nil)
    }
    class func showGpsAlert (title:String,message:String,view:SplashViewController){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: UIAlertActionStyle.default, handler: {(_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                    view.accessLocation()
                })
            }}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {action in
            var loc = CLLocation(latitude: 29.315654, longitude: 28.46415)
            view.sendLocation(location:loc )}))
        view.present(alert, animated: true, completion: nil)
    }
    
}
