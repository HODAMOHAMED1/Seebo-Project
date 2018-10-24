//
//  Presenter.swift
//  Seebo Project 
//
//  Created by Admin on 10/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

class FBPresenter :NSObject ,FBRegisterPresenterProtocol{
    
var view:FBRegisterViewProtocol!
var items = [Item]()
    
init(RegView:FBRegisterViewProtocol) {
    view = RegView
    super.init()
}
    func fbRegisterRequest(fullname:String,email:String,phone:String,validEmail:Bool){
        FBRegisterManager.manager.fbRegisterRequset(url: Constants.registerFacebookApi, fullname: fullname, email: email,phone: phone, validEmail:validEmail, onSuccess: { (userData,flag) in
            if (userData == nil && flag == 1){
                print("account used before")
            }else{
                print( "You have created new account, Check your inbox to verify your account")
                Helper.setUserData(userData: userData!)
                self.view.accessDataToHome()
                print(userData?.phone)
            }
        })
    }
    func getItems(location: CLLocation) {
        SplashManager.manager.getItems(onSuccess: {
            (items) in
            self.items = items
            Helper.setDataToHome(items: items, view: view as! FBRegisterViewController,splash: 2)
        })
    }
}
