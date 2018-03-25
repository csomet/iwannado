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


func getCompletedProgress()-> Float{
    
    var completedItem : Float = 0
    var progress : Float = 0
    
    if App.items.count > 0 {
        for item in App.items {
            if item.isDone{
                completedItem = completedItem + 1
            }
        }
        
         progress = completedItem / Float(App.items.count)
    }
    
    let progressRounded = String(format:"%.1f", progress)
    
    return Float(progressRounded)!
}
