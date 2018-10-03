//
//  SplashPresenter.swift
//  Seebo Project 
//
//  Created by Admin on 10/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class SplashPresenter: NSObject ,SplashPresenterProtocol {
    
    var view :SplashViewProtocol
    var items = [Item]()
     init(vieww : SplashViewProtocol) {
        self.view = vieww
        super.init()
        SplashManager.manager.getItems(onSuccess: {
            (items) in
            self.items = items
        })
    }
    func getItems()->[Item] {
        
        return items
    }
     func setLocation(location: CLLocation){
        var userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: location)
        userDefaults.set(encodedData, forKey: "location")
        userDefaults.synchronize()
    }
    func getLocation()->CLLocation {
        var userDefaults = UserDefaults.standard
        let location = CLLocation()
        if let locationData  = userDefaults.object(forKey: "location") {
            let locationdata = locationData as! Data
            let location = NSKeyedUnarchiver.unarchiveObject(with: locationdata) as! CLLocation
        }
      return location
    }
}