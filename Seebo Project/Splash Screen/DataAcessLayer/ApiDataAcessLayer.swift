//
//  ApiDataAcessLayer.swift
//  Seebo Project 
//
//  Created by Admin on 10/1/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ApiDataAcessLayer: NSObject {
    var  items = [Item]()
    
    func loadItems()->[Item] {
        
        let item1 = Item(name: "dress",description: "Dress")
        let item2 = Item(name: "jacket",description:"Jacket")
        let item3 = Item(name: "shoes",description: "Dshoes")
        let item4 = Item(name: "dress",description: "Dress")
        let item5 = Item(name: "jacket",description:"Jacket")
        let item6 = Item(name: "shoes",description: "Dshoes")
        items = [item1,item2,item3,item4,item5,item6]
        return items
    }
    
    func getItems(onSuccess success:(_ items:[Item])->Void) {
        
        success(loadItems())
    }
}
