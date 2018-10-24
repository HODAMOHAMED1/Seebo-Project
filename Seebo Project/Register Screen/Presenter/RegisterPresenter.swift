//
//  RegisterPresenter.swift
//  Seebo Project 
//
//  Created by Admin on 10/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class RegisterPresenter :NSObject ,RegisterPresenterProtocol {
    
    var view:RegisterViewProtocol!
    
    init(RegView:RegisterViewProtocol) {
        view = RegView
        super.init()
    }
    func registerRequest(fullname:String,email:String,password:String,repassword:String,phone:String){
        RegisterManager.manager.registerRequset(url: Constants.signUpApi, fullname: fullname, email: email, password: password, repassword: repassword, phone: phone, onSuccess: { code in
            if (code == 1){
                self.view.showAlertMessage(message: "The password and re password not matched")
            }else if (code == 2){
                self.view.showAlertMessage(message:"Sorry u can't use this email because it's already taken")
            }else if (code == 3){
                self.view.showAlertMessage(message: "Please enter your phone")
            }else{
                self.view.showToastMessage(message: "You have created new account, Check your inbox to verify your account")
            }
        })
    }
}
