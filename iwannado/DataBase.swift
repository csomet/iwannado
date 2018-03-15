//
//  DataBase.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 12/3/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import UIKit
import CoreData

/**
 This singleton class manage operations between application and the Database. You can use the singleton by calling `sharedInstance` property. It is used for CoreData.
 - author: Carlos H Somet
 - important: You don't need to instantiate this class
 - Requires: `CoreData`
 - version: 1.0
 */
class DataBase {
    
    static let sharedInstance = DataBase()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    
    /**
     Load items from the database.
     - parameter request: This is an optional param which contains Items the fetchrequest by default.
 
     */
    func loadItemsFromDB(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        
        do {
            App.items = try context.fetch(request)
        } catch {
            print("Error loading items: \(error)")
        }
        
    }
    
    
    /**
     Load items from the database depending on Task selected.
     - parameter request: This is an optional param which contains Items fetchrequest by default.
     - parameter selectedTask: Task which owns the items we are looking for in DB.
     */
    func loadItemsFromDB(with request: NSFetchRequest<Item> = Item.fetchRequest(), selectedTask : Task){
        
        let taskPredicate = NSPredicate(format: "parentTask.name MATCHES %@", (selectedTask.name!))
        
        request.predicate = taskPredicate
        
        do {
            App.items = try context.fetch(request)
        } catch {
            print("Error loading items: \(error)")
        }
        
    }
    
    /**
     Load tasks from the database.
     - parameter request: This is an optional param which contains the tasks fetchrequest by default.
     
     */
    func loadTasksFromDB(with request: NSFetchRequest<Task> = Task.fetchRequest()){
        
        do {
            App.tasks = try context.fetch(request)
        } catch{
            print("Error loading from db: \(error)")
        }
        
    }
    
    /**
     Create and insert a new Task into the database.
     - parameter name: Task title.
     - parameter type: Type of task
     ## See also:
     System.swift file.
     */
    func insertNewTaskInDataBase(name: String, type: String){
        
        let newTask = Task(context: context)
        newTask.name = name
        newTask.type = type
        newTask.completed = 0
        
        App.tasks.append(newTask)
        
        saveContext()
    }
    
    /**
     Create and insert a new Item into the database.
     - parameter name: Item title.
     - parameter parentTask: The task which contains the item created.
     ## See also:
     System.swift file.
     */
    func insertNewItemInDataBase(name: String, parentTask: Task){
        
        let newItem = Item(context: context)
        newItem.isDone = false
        newItem.itemName = name
        newItem.parentTask = parentTask
        
        App.items.append(newItem)
        
        saveContext()
    }
    
    
    /**
     Delete a Task from the database and task array. It also deletes all items within the selected task.
     - parameter name: Task we want to delete.
     */
    func deleteTask(task: Task){
 
        loadItemsFromDB(selectedTask: task)
        
        
        for item in App.items {
            context.delete(item)
        }
        
        App.items.removeAll()
       
        context.delete(task)
        
        saveContext()
        
        loadTasksFromDB()
    }
    
    /**
     Delete a Item from the database.
     - parameter name: Item we want to delete.
     */
    func deleteItem(item: Item){
        
        var parentTask : Task?
        
        parentTask = item.parentTask
        
        context.delete(item)
        
        saveContext()
        
        loadItemsFromDB(selectedTask: parentTask!)
    
   
    }
    
    
    /**
     Execute commit (save changes) to the data base.
     No params needed.
     */
    func saveContext(){
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
    }
    
    
    /**
     Execute rollback (revert changes) to the data base.

     */
    func rollbackContext(){
        
        context.rollback()
    
    }
    
    
    
    
}
