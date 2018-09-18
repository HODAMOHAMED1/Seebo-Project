//
//  Manager.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class Manager: NSObject {
    
    static let manager = Manager()
    private let dataAccess = LocalDataAcess()
    var allItems:[Item]!
    
    private override init() {
    }
    
    func getItems(onSuccess success:(_ items:[Item])->Void) {
        
        dataAccess.getItems(onSuccess: success)
    }
}
