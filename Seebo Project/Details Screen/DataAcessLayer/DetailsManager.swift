//
//  DetailsManager.swift
//  Seebo Project 
//
//  Created by Admin on 9/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class DetailsManager: NSObject {
    
    static let manager = DetailsManager()
    private let dataAccess = DataAcessLayer()
    var Reviews = [Review]()
    
    private override init() {
    }
    
    func getReviews(url:String,id:Int,onSuccess success:@escaping (_ reviews:[Review])->Void) {
        
        dataAccess.getReviews(url: url, id: id, onSuccess: { json in
            let reviews = json["data"]["list"]
            print("rrrrrrrrrr\(reviews.count)")
            self.Reviews.removeAll()
            if reviews.count > 0
            {
                for i in 0...reviews.count-1
                {
                    let review = Review(review: reviews[i])
                    self.Reviews.append(review)
                }
            }
            success(self.Reviews)
        })
    }
}
