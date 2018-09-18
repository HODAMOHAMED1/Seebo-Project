//
//  Model.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class Item: NSObject {
    
    var imagename:String?
    var imageDescription:String?
    
    init(name:String,description:String) {
        
        self.imagename=name
        self.imageDescription=description
    }
}
