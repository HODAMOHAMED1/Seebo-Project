//
//  RegisterPresenterProtocol.swift
//  Seebo Project 
//
//  Created by Admin on 10/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol RegisterPresenterProtocol {
    func registerRequest(fullname:String,email:String,password:String,repassword:String,phone:String)
}
