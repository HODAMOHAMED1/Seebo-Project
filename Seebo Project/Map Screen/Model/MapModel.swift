//
//  MapModel.swift
//  Seebo Project 
//
//  Created by Admin on 9/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class advertisment:NSObject {
    
    var numberOfAdv : Int?
    var numberOfPages :Int?
    var adv_id :Int?
    var adv_title : String?
    var subCategory_id:Int?
    var subCategory_title:String?
    var category_id:Int?
    var category_title:String?
    var image:String?
    var descrip: String?
    var price : Int?
    var firmPrice : Bool?
    var trade: Bool?
    var lat: String?
    var lng: String?
    var avgRate:Int?
    var lastreview :Review?
    var absoluteRoute : String?
    var images:[String]?
    var mainImage: String?
    var subattributes:[Attribute]?
    var brand_id :Int?
    var brand_title:String?
    var model_id:Int?
    var model_title:String?
    var year:Int?
    var distance:Int?
    var userobj:User?
    
    init(json: JSON) {
        
        if let idadv = json["id"].int {
            
            adv_id = idadv
        }
        
        if let titleadv = json["title"].string {
            
            adv_title = titleadv
        }
        
        if let subcat_id = json["subCategory"]["id"].int {
            
            subCategory_id = subcat_id
        }
        
        if let subcat_title = json["subCategory"]["title"].string {
            
            subCategory_title = subcat_title
        }
        
        if let cat_id = json["subCategory"]["category"]["id"].int {
            
            category_id = cat_id
        }
        
        if let cat_title = json["subCategory"]["category"]["title"].string {
            
            category_title = cat_title
        }
        
        if let imagestr = json["subCategory"]["category"]["image"].string {
            
            image = imagestr
        }
        
        if let descripstr = json["description"].string {
            
            descrip = descripstr
        }
        
        if let pricevalue = json["price"].int {
            
            price = pricevalue
        }
        
        if let firm_price = json["firmPrice"].bool {
            
            firmPrice = firm_price
        }
        
        if let trade_bool = json["trade"].bool {
            
            trade = trade_bool
        }
        
        if let lat_str = json["lat"].string {
            
            lat = lat_str
        }
        
        if let long_str = json["lng"].string {
            
            lng = long_str
        }
        if let rate = json["avgRate"].int{
            avgRate = rate
        }
        if let revieww = json["lastReview"].dictionary{
            
            lastreview = Review (review: JSON(revieww))
        }
        if let user = json["user"].dictionary{
            
            userobj = User (user: JSON(user))
        }
        if let images_arr = json["images"].array {
            images = [String]()
            if (images_arr.count > 0) {
            for i in 0...images_arr.count-1
            {
                var imagestr:String = images_arr[i]["path"].string!
                images?.append(imagestr)
                print (imagestr)
            }
           }
          }
        
        if let main_img = json["mainImage"].string {
            
            mainImage = main_img
        }
        
        if let sub_attributes = json["subAttributes"].array {
            
            subattributes = [Attribute]()
            if (sub_attributes.count > 0) {
                for i in 0...sub_attributes.count-1
                {
                    let subattribute = Attribute(attribute: sub_attributes[i])
                    subattributes?.append(subattribute)
                }
            }
        }
        
        if let brandid = json["brand"]["id"].int {
            
            brand_id = brandid
        }
        
        if let brandtitle = json["brand"]["title"].string {
            
            brand_title = brandtitle
        }
        
        if let modelid = json["model"]["id"].int {
            
            model_id = modelid
        }
        
        if let modeltitle = json["model"]["title"].string {
            
            model_title = modeltitle
        }
        
        if let year_num = json["year"].int {
            
            year = year_num
        }
        
        if let distance_num = json["distance"].int {
            
            distance = distance_num
        }
    }
}
