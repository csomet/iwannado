//
//  Item.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 7/3/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import Foundation

class Item {
    
    //MARK: - PROPERTIES
    
    var itemName : String?
    var isDone   : Bool?
    
    
    init(item: String){
        self.itemName = item
        self.isDone = false
    }
    
}
