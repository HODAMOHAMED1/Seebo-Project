//
//  Review.swift
//  Seebo Project 
//
//  Created by Admin on 9/20/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Review: NSObject {
    
    var reviewid :Int?
    var user : User?
    var adv_id :Int?
    var review_str: String?
    var rate : Int?
    var created : String?

    override init() {
        
    }
    init(review:JSON) {
        
        if let re_id = review["id"].int {
            
            reviewid = re_id
        }
        if let user_review = review["user"].dictionary{
            
            var userr = User(user:JSON(user_review))
            user = userr
        }
        if let id = review["advertisement"].int {
            
            adv_id = id
        }
        if let revieww = review["review"].string {
            
            review_str = revieww
        }
        if let ratee = review["rate"].int {
            
            rate = ratee
        }
        if let create = review["created"].string {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+3:00")
            let date = dateFormatter.date(from: create)
            print ("hiiii\(date)")
            created = date?.displayTimeFromNow()
        }
    }
}
