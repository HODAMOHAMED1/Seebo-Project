//
//  Attribute.swift
//  Seebo Project 
//
//  Created by Admin on 9/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Attribute: NSObject {
    
    var subattribute_id :Int?
    var subattribute_title:String?
    var attribute_id:Int?
    var attribute_title:String?
    
     init(attribute:JSON) {
        
        if let sub_id = attribute["id"].int {
            
            subattribute_id = sub_id
        }
        
        if let sub_title = attribute["title"].string {
            
            subattribute_title = sub_title
        }
        
        if let attr_id = attribute["attribute"]["id"].int {
            
            attribute_id = attr_id
        }
        
        if let attr_title = attribute["attribute"]["title"].string {
            
            attribute_title = attr_title
        }
    }
}
