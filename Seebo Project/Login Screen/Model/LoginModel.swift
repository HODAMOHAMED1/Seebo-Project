//
//  LoginModel.swift
//  Seebo Project 
//
//  Created by Admin on 10/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserObj :NSObject,NSCoding {

    var apiKey:String?
    var name:String?
    var email:String?
    var image:String?
    var phone:String?
    
    override init(){}
    init(user:JSON) {
        
        if let apiKeyStr = user["apiKey"].string {
            self.apiKey = apiKeyStr
        }
        if let nameStr = user["name"].string {
            self.name = nameStr
        }
        if let emailStr = user["email"].string {
            self.email = emailStr
        }
        if let imageStr = user["image"].string {
            self.image = imageStr
        }
        if let phoneStr = user["phone"].string {
            self.phone = phoneStr
        }
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(apiKey, forKey: "apiKey")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(phone, forKey: "phone")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.apiKey = aDecoder.decodeObject(forKey: "apiKey") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.image = aDecoder.decodeObject(forKey: "image") as? String
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
    }
}
