//
//  RegisterManager.swift
//  Seebo Project 
//
//  Created by Admin on 10/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class RegisterManager: NSObject {
    static let manager = RegisterManager()
    
    private override init() {
    }
    func registerRequset(url:String,fullname:String,email:String,password:String,repassword:String,phone:String,onSuccess success:@escaping (_ flag:Int)->Void) {
        let param = [
            "fullname":fullname,
            "email":email,
            "password":password,
            "rePassword":repassword,
            "phone":phone
            ] as! [String : String]
        
        Network.requestPostApi(url: url, param: param as [String : AnyObject], onSuccess: { json in
            let error = json["errors"].array
            if error?.count != 0 {
                for i in 0...(error?.count)!-1{
                    if error![i] == "The password and re password not matched"{
                       success(1)
                    }
                    else if error![i] == "Sorry u can't use this email because it's already taken" {
                        success(2)
                    }
                    else if error![i] ==  "Please enter your phone" {
                        success(3)
                    }else{
                        print("no error")
                    }
                }
            }else{
                success(0)
            }
        })
    }
}
