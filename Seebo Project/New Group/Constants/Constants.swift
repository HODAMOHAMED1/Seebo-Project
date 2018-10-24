//
//  Constants.swift
//  Seebo Project 
//
//  Created by Admin on 10/11/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

struct Constants{
    static var appLang = "en"
    static var isLogin = false
    static var deviceToken = "6e14ebecfa5341ec16d7649e623a71968d0c0105"
    static var userFbId = ""
    static var device = "ios"
    static  var locationManager = CLLocationManager()
    //MARK:- ApiConstants
    static let apiLink = "http://50.87.52.41/~develps7/Seebo-me/web/app_dev.php/"
    static let allReviewsApi = "advertisement/review-filter"
    static let advertisementFilterApi = "advertisement/filter"
    static let loginApi = "login"
    static let signUpApi = "sign-up"
    static let checkFacebookApi = "check-facebook"
    static let registerFacebookApi = "facebook"
}
