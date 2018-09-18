//
//  MapPresenter.swift
//  Seebo Project 
//
//  Created by Admin on 9/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

class MapPresenter: NSObject,MapPresenterPro {

    var view : MapViewPro
    var advertisments = [advertisment]()
    
    init(view:MapViewPro) {
        
        self.view = view
        super.init()
    }
    
    func getAllAdvertisments(long:String,lat:String) {
        
        MapManager.manager.getAdvertisments(url: "http://50.87.52.41/~develps7/Seebo-me/web/app_dev.php/en/api/advertisement/filter", long: long, lat: lat, onSuccess: { alladversts in
            self.advertisments = alladversts
            self.view.reloadData()
            print(self.advertisments.count)
        })
    }
    
    func setLocation(location: CLLocation) {
        
        print("yy\(location)")
        let longitude = String (Double(location.coordinate.longitude))
        let latitude = String (Double(location.coordinate.latitude))
        self.getAllAdvertisments(long: longitude, lat: latitude)
        print(advertisments.count)
    }
    
    func getNumberOfAdvertisments()-> Int {
        
        return advertisments.count
    }
    
    func getAdvertisments()->[advertisment] {
        
        return advertisments
    }
}
