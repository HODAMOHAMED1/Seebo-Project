//
//  MapManager.swift
//  Seebo Project 
//
//  Created by Admin on 9/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class MapManager: NSObject {
    
    static let manager = MapManager()
    private let dataAccess = ApiLocalDataAcess()
    var allAdvert = [advertisment]()
    
    private override init() {
    }
    
    func getAdvertisments(url:String,long:String,lat:String,onSuccess success:@escaping (_ advertisments:[advertisment])->Void) {
        
        dataAccess.getAdvertesments(url:url,longitude:long, latitude:lat, onSuccess: { json in
            let advertisments = json["data"]["list"]
           print("rrrrrrrrrr\(advertisments.count)")
             self.allAdvert.removeAll()
            if advertisments.count > 0
            {
                for i in 0...advertisments.count-1
                {
                    let advert = advertisment(json: advertisments[i])
                    self.allAdvert.append(advert)
                }
            }
            success(self.allAdvert)
    })
    }
}
