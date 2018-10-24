//
//  LoginManager.swift
//  Seebo Project 
//
//  Created by Admin on 10/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class LoginManager: NSObject {
static let manager = LoginManager()

private override init() {
}
    func loginRequset(url:String,email:String,password:String,onSuccess success:@escaping (_ user:UserObj?)->Void) {
    let param = [
        "_username":email,
        "_password":password,
        "version":1.0,
        "device_token":Constants.deviceToken,
        "device":"ios"
        ] as [String : Any]
        
    Network.requestPostApi(url: url,param: param as [String : AnyObject],onSuccess: { json in
        let error = json["errors"].array
        if error?.count != 0 {
            print("invalid email or password")
            success(nil)
        }else{
         let userData = json["data"]
            let userObj = UserObj(user: userData)
            print(userObj.apiKey!)
            print(Constants.deviceToken)
         success(userObj)
        }
    })
}
    func checkFacebook(url:String,email:String,onSuccess success:@escaping (_ user:UserObj?,_ flag:Int)->Void){
        let param = [
            "device":Constants.device,
            "email":email,
            "fb_id":Constants.userFbId,
            "version":1.0
            ] as [String : Any]
        
        Network.requestPostApi(url: url,param: param as [String : AnyObject],onSuccess: { json in
            let error = json["errors"].array
            if error?.count != 0 {
                for i in 0...(error?.count)!-1{
                    if error![i] == "Please fill your data"{
                        success(nil,1)
                    }
                    else if error![i] == "facebookId is missing" {
                        success(nil,2)
                    }
                  else{
                        print("no error")
                    }
                }
            }else{
                let userData = json["data"]
                let userObj = UserObj(user: userData)
                print(userObj.apiKey!)
                success(userObj,0)
            }
        })
    }
}
