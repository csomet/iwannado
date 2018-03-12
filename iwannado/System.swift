//
//  System.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 8/3/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import UIKit


struct App {
    static var tasks : [Task] = [Task]()
    static var items : [Item] = [Item]()
}


struct Data {
    
    struct TaskType {
        static let SHOPPING : String = "shopping"
        static let TODOLIST : String = "todo"
    }
}
