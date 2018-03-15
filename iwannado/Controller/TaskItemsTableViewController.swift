//
//  TaskItemsTableViewController.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 6/3/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import UIKit

class TaskItemsTableViewController: UITableViewController {

    var selectedTask : Task? {
        didSet{
            DataBase.sharedInstance.loadItemsFromDB(selectedTask: selectedTask!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }
    
    
    @IBAction func addNewItemTodo(_ sender: UIBarButtonItem) {
        
        var textFieldItem = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            
            DataBase.sharedInstance.insertNewItemInDataBase(name: textFieldItem.text!, parentTask: self.selectedTask!)
            
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (textField) in
            
            textFieldItem = textField
            textFieldItem.placeholder = ""
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath) as! ItemTableViewCell
        
        cell.indexPath = indexPath
        cell.itemTextLabel.text = App.items[indexPath.row].itemName
        
        if App.items[indexPath.row].isDone  == true {
            cell.checkBoxButton.setImage(UIImage(named:"icon-checkbox-selected-25x25"), for: .normal)
        } else {
             cell.checkBoxButton.setImage(UIImage(named:"icon-checkbox-unselected-25x25"), for: .normal)
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let parentTask : Task = App.items[indexPath.row].parentTask!
        
        if editingStyle == .delete {
            DataBase.sharedInstance.deleteItem(item: App.items[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        parentTask.completed = getCompletedProgress()
        
        DataBase.sharedInstance.saveContext()
    }

    

}
