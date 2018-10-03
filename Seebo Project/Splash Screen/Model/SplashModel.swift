//
//  SplashModel.swift
//  Seebo Project 
//
//  Created by Admin on 10/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

    class Item: NSObject {
        
        var imagename:String?
        var imageDescription:String?
        
        init(name:String,description:String) {
            
            self.imagename=name
            self.imageDescription=description
        }
}
