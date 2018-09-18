//
//  LocalDataAccess.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class LocalDataAcess: NSObject {
    
    var  items = [Item]()
    
    func loadItems()->[Item] {
        
        let item1 = Item(name: "dress",description: "Dress")
        let item2 = Item(name: "jacket",description: "Jacket")
        let item3 = Item(name: "shoes",description: "Dshoes")
        items = [item1,item2,item3]
        return items
    }
    
    func getItems(onSuccess success:(_ items:[Item])->Void) {
        
        success(loadItems())
    }
}
