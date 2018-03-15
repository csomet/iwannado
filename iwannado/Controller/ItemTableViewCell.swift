//
//  ItemTableViewCell.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 12/3/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import UIKit
import CoreData

class ItemTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var itemTextLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var indexPath : IndexPath = IndexPath()
    
    @IBAction func activateCheckBox(_ sender: UIButton) {
        
        if !App.items[indexPath.row].isDone {
            App.items[indexPath.row].isDone = true
            checkBoxButton.setImage(UIImage(named: "icon-checkbox-selected-25x25"), for: .normal)
        } else {
            App.items[indexPath.row].isDone = false
            checkBoxButton.setImage(UIImage(named: "icon-checkbox-unselected-25x25"), for: .normal)
        }
        
        for task in App.tasks {
            if task == App.items[indexPath.row].parentTask{
                task.completed = getCompletedProgress()
            }
        }
        
        
        DataBase.sharedInstance.saveContext()
        
    }
    
}


