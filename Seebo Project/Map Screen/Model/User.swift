//
//  User.swift
//  Seebo Project 
//
//  Created by Admin on 9/20/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject {
    
    var username :String?
    var email :String?
    var image :String?
    var phone :String?
    
    init(user:JSON) {
        
        if let name = user["name"].string {
            username = name
        }
        if let uemail = user["email"].string {
            email = uemail
        }
        if let uimage = user["image"].string {
            image = uimage
        }
        if let uphone = user["phone"].string {
            phone = uphone
        }
    }
}
