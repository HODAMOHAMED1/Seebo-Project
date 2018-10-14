//
//  SplashViewPresenter.swift
//  Seebo Project 
//
//  Created by Admin on 10/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

protocol SplashViewProtocol {
    func setItems(items:[Item])
    func sendLocation(location:CLLocation)
}
