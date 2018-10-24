//
//  LoginPresenterProtocol.swift
//  Seebo Project 
//
//  Created by Admin on 10/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

protocol LoginPresenterProtocol {
    
    func loginRequest(email:String,password:String)
    func checkFacebook()
    func fetchProfile()
    func getItems(location: CLLocation)
}
