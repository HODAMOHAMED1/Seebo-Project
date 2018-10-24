//
//  FBRegisterPresenterProtocol.swift
//  Seebo Project 
//
//  Created by Admin on 10/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

protocol FBRegisterPresenterProtocol {
    
    func fbRegisterRequest(fullname:String,email:String,phone:String,validEmail:Bool)
    func getItems(location: CLLocation)
}
