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
    }
    func getItems(location: CLLocation) {
        SplashManager.manager.getItems(onSuccess: {
            (items) in
            self.items = items
            Helper.setDataToHome(items: items, view: view as! SplashViewController ,splash:0)
        })
    }
     
}
