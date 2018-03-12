//
//  AddNewCollectionViewController.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 28/2/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import UIKit
import TransitionButton

class AddNewCollectionViewController: CustomTransitionViewController {

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var todoListButton: UIButton!
    @IBOutlet weak var shoppingListButton: UIButton!
    
    var radioButtonController: SSRadioButtonsController?
    var selectedTypeTask : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskName.delegate = self
        
        radioButtonController = SSRadioButtonsController(buttons: todoListButton,shoppingListButton)
        radioButtonController?.delegate = self
        radioButtonController?.shouldLetDeSelect = false
    }
    
    

    @IBAction func saveButton(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
            //Create Task in DB
            DataBase.sharedInstance.insertNewTaskInDataBase(name: taskName.text!, type: selectedTypeTask!)
            
          self.dismiss(animated: true, completion: nil)
            
        } else if sender.tag == 0 {
            
             self.dismiss(animated: true, completion: nil)
        }
        
       
    }


}


extension AddNewCollectionViewController : SSRadioButtonControllerDelegate {
    
    func didSelectButton(selectedButton: UIButton?) {
        
        if selectedButton == todoListButton {
            selectedTypeTask = Data.TaskType.TODOLIST
            
        } else if selectedButton == shoppingListButton {
            selectedTypeTask = Data.TaskType.SHOPPING
        }
    }
    
}

extension AddNewCollectionViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}



