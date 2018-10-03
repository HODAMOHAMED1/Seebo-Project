//
//  SplashPresenterProtocol.swift
//  Seebo Project 
//
//  Created by Admin on 10/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

protocol SplashPresenterProtocol {
    
    func getItems()->[Item]
    func setLocation(location: CLLocation)
    func getLocation()->CLLocation 
}
