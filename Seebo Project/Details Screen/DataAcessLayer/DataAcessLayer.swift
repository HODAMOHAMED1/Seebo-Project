//
//  DataAcessLayer.swift
//  Seebo Project 
//
//  Created by Admin on 9/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataAcessLayer: NSObject {
    
    func getReviews(url:String,id:Int,onSuccess success:@escaping (_ json:JSON)->Void) {
        let param = [
            "id":id
        ]
        let headers = ["token":"6e14ebecfa5341ec16d7649e623a71968d0c0105",
                       "Content-Type": "application/json"]
        
        Alamofire.request(url, method:.post, parameters: param, encoding: JSONEncoding.default, headers:headers).responseJSON(completionHandler: { response in
            guard response.result.error==nil else
            {
                print("error calling POST")
                print(response.result.error!)
                return
            }
            guard let jsonobj=response.result.value as? [String:Any] else{
                print("didn't get object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            let jsondata = JSON(jsonobj)
            print(jsondata)
            success(jsondata)
        })
    }
}
