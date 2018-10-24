//
//  FBRegisterManager.swift
//  Seebo Project 
//
//  Created by Admin on 10/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class FBRegisterManager: NSObject {
    
static let manager = FBRegisterManager()

private override init() {
}
    func fbRegisterRequset(url:String,fullname:String,email:String,phone:String,validEmail:Bool,onSuccess success:@escaping (_ user:UserObj?,_ flag:Int)->Void) {
        let param = [
            "fullname":fullname,
            "email":email,
            "phone":phone,
            "fb_id":Constants.userFbId,
            "valid_email":validEmail
            ] as! [String : Any]
        
        Network.requestPostApi(url: url, param: param as [String : AnyObject], onSuccess: { json in
            let error = json["errors"].array
            if error?.count != 0 {
                print ("FBERORR")
                success(nil,1)
            }else{
                let userData = json["data"]
                let userObj = UserObj(user: userData)
                print(userObj.apiKey!)
                success(userObj,0)
            }
        })
    }
}
