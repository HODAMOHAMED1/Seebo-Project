//
//  Presenter.swift
//  HomeScreen_TaskPerfect
//
//  Created by Admin on 9/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class HomePresenter: NSObject,HomePresenterPro {
    
    var view :HomeViewPro
    var items = [Item]()
    var filterdata = [Item]()
    
    init(viewinit:HomeViewPro) {
        
        self.view = viewinit
        super.init()
    }
    func setItems( items :[Item]) {
        self.items = items
    }
    
    func getNumberOfSections() -> Int {
        
        return 1
    }
    
    func getNumberOfItems() -> Int {
        
        return items.count
    }
    
    func getItems()->[Item] {
        
        return items
    }
    
    func FilteredData(searchText:String) {
        
        filterdata = items.filter({(item:Item)->Bool in
            if (item.imageDescription?.contains(searchText))!
            {
                return true
            }else
            {
                return false
            }
            view.reloadfunc()
        })
    }
    
   func getNumberOfFilters()->Int {
    
    print(filterdata.count)
    return filterdata.count
    }
    
    func getFilters() -> [Item] {
        
    return filterdata
    }
}
