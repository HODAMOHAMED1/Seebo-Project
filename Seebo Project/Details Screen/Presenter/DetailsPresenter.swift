//
//  DetailsPresenter.swift
//  Seebo Project 
//
//  Created by Admin on 9/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class DetailsPresenter: NSObject,DetailsPresenterPro{
    
    var view : DetailsViewPro
    var reviews = [Review]()

    init(view:DetailsViewPro) {
        
        self.view = view
        super.init()
    }
    
    func getAllReviewsById(id:Int) {
        DetailsManager.manager.getReviews(url: "http://50.87.52.41/~develps7/Seebo-me/web/app_dev.php/en/api/advertisement/review-filter", id: id, onSuccess: { allreviews in
            self.reviews = allreviews
            self.view.reloadData()
            print(self.reviews.count)
        })
    }
    func getReviews()->[Review]{
        return reviews
    }
    func getReview(index:Int)->Review {
        
        return reviews[index]
    }
    func getNumberOfReviews()-> Int {
        
        return reviews.count
    }
}
