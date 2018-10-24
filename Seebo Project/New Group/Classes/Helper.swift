//
//  Helper.swift
//  Seebo Project 
//
//  Created by Admin on 10/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Helper : NSObject {
     
    //MARK:- Validation
    class func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    class func isValidPassword(paswordStr:String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        //"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: paswordStr)
    }
    class func isValidPhone(str:String)->Bool {
            let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            let result =  phoneTest.evaluate(with: str)
            return result
    }
    
    class func isAllDigits(str:String)->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = str.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  str == filtered
    }
    //MARK:- AccesssLocation
    class func setLocation(location: CLLocation){
        var userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: location)
        userDefaults.set(encodedData, forKey: "location")
        userDefaults.synchronize()
    }
    class func getLocation()->CLLocation? {
        var location : CLLocation?
        var userDefaults = UserDefaults.standard
        if let locationData  = userDefaults.object(forKey: "location") {
            let locationdata = locationData as! Data
            location = NSKeyedUnarchiver.unarchiveObject(with: locationdata) as! CLLocation
        }
        return location
    }
     //MARK:- AccessDataToHome
    class func setDataToHome(items:[Item],view:UIViewController,splash:Int){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let home = tabController.viewControllers![0] as! HomeScreenViewController
        home.items = items
        if splash == 0{
            (view as! SplashViewController).navigationController?.pushViewController(tabController, animated: true)
        }else if splash == 1{
            (view as! LoginScreenViewController).navigationController?.pushViewController(tabController, animated: true)
        }
        else {
            (view as! FBRegisterViewController).navigationController?.pushViewController(tabController, animated: true)
        }
        
    }
    //MARK:- SetUserObject
    class func setUserData(userData:UserObj){
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: userData)
        userDefaults.set(encodedData, forKey: "userObject")
        userDefaults.synchronize()
    }

    //MARK:- CheckLogin
    class func checkLogin()->Bool {
        return UserDefaults.standard.object(forKey: "userObject") != nil
    }
}
