//
//  DetailsPresenterPro.swift
//  Seebo Project 
//
//  Created by Admin on 9/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol DetailsPresenterPro {
    
    func getAllReviewsById(id:Int)
    func getReviews()->[Review]
    func getReview(index:Int)->Review
    func getNumberOfReviews()-> Int 
}
