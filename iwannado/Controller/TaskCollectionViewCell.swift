//
//  TaskCollectionViewCell.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 1/3/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import UIKit
import GTProgressBar

protocol TaskCollectionViewCellUpdater {
    func collectionViewUpdate()
}

class TaskCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var TaskImage: UIImageView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var progressBar: GTProgressBar!
    
    var delegate : TaskCollectionViewCellUpdater?
    var Task : Task?
    
    @IBAction func deleteTask(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "", message: "Are you sure you want to delete this task and all its items?", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
            DataBase.sharedInstance.deleteTask(task: self.Task!)
            self.delegate?.collectionViewUpdate()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
      
    }

    
}
