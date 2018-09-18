//
//  PresenterProtocol.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
protocol PresenterPro {
    
    func getNumberOfItems()->Int
    func getNumberOfSections()->Int
    func getItems()->[Item]
    func FilteredData(searchText:String)
    func getNumberOfFilters()->Int
    func getFilters()->[Item]
}
