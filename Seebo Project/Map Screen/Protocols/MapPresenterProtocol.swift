//
//  MapPresenterProtocol.swift
//  Seebo Project 
//
//  Created by Admin on 9/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation

protocol MapPresenterPro {
    
    func getAllAdvertisments(long:String,lat:String)
    func setLocation(location:CLLocation)
    func getNumberOfAdvertisments()-> Int
    func getAdvertisments()->[advertisment]
    func getAdvertisment(index:Int)->advertisment
    func getDataDefaultLocation()
}
