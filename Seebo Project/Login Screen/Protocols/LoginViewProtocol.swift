//
//  LoginViewProtocol.swift
//  Seebo Project 
//
//  Created by Admin on 10/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

protocol LoginViewProtocol {
    func accessDataToHome()
    func showInvalidEmailOrPassword()
    func fillData(user:UserObj)
}
