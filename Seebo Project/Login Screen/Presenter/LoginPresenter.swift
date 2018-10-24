//
//  LoginPresenter.swift
//  Seebo Project 
//
//  Created by Admin on 10/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation
import FBSDKCoreKit
import FBSDKLoginKit

class LoginPresenter:NSObject,LoginPresenterProtocol {
    var view:LoginViewProtocol!
    var user = UserObj()
    var items = [Item]()
    init(loginView:LoginViewProtocol) {
        
        self.view = loginView
        super.init()
    }
    func loginRequest(email:String,password:String){
      LoginManager.manager.loginRequset(url: Constants.loginApi, email: email, password: password, onSuccess: { userObject in
        if (userObject == nil){
             self.view.showInvalidEmailOrPassword()
        }else{
        self.user = userObject!
        Helper.setUserData(userData: self.user)
        print(self.user.email!)
        self.view.accessDataToHome()
        }
      })
    }
    func checkFacebook(){
        LoginManager.manager.checkFacebook(url: Constants.checkFacebookApi, email: self.user.email!,onSuccess: { (userObject,flag) in
            if (userObject == nil && flag == 1){
                print("fill data")
                self.view.fillData(user: self.user)
            }
            if (userObject != nil){
                Helper.setUserData(userData: userObject!)
                self.view.accessDataToHome()
                print("done")
            }
        })
    }
    func fetchProfile(){
        print("fetch")
        let parameters = ["fields":"id,email,name,picture.type(large)"]
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: parameters)
        graphRequest.start(completionHandler: {con,res,err in
            
            if (err != nil)
            {
                print("error")
                return
            }
            let details = res as! NSDictionary
            if let id = details["id"] as? String {
                Constants.userFbId = id
                print(id)
            }
            if let email = details["email"] as? String {
                self.user.email = email
                print(self.user.email)
            }else{
                self.user.email = ""
            }
            if let name = details["name"] as? String {
                self.user.name = name
                print(name)
            }
            if let picture = details["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary , let url = data["url"] as? String{
                self.user.image = url
                print(url)
            }
            self.checkFacebook()
        })
    }
    func getItems(location: CLLocation) {
        SplashManager.manager.getItems(onSuccess: {
            (items) in
            self.items = items
            Helper.setDataToHome(items: items, view: view as! LoginScreenViewController,splash: 1)
        })
    }
}
