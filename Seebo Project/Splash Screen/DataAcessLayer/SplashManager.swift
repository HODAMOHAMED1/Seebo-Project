//
//  SplashManager.swift
//  Seebo Project 
//
//  Created by Admin on 10/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class SplashManager: NSObject {
    static let manager = SplashManager()
    private let dataAccess = ApiDataAcessLayer()
    var allItems:[Item]!
    
    private override init() {
    }
    
    func getItems(onSuccess success:(_ items:[Item])->Void) {
        
        dataAccess.getItems(onSuccess: success)
    }
}
