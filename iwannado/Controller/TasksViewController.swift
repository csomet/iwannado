//
//  ViewController.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 28/2/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import UIKit
import TransitionButton

class TasksViewController: UIViewController {
    
   
    //MARK: - OUTLETS
    @IBOutlet weak var taskCollectionView: UICollectionView!
    @IBOutlet weak var noTasksLabel: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskCollectionView.dataSource = self
        self.taskCollectionView.delegate = self
        
        DataBase.sharedInstance.loadTasksFromDB()
     
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadCollectionViewAnimated()
        hideCollectionViewWhenNoData()
    }
    
    

    func hideCollectionViewWhenNoData(){
        if App.tasks.count == 0 {
            taskCollectionView.isHidden = true
        } else {
            taskCollectionView.isHidden = false
        }
    }
    
    
    func reloadCollectionViewAnimated(){
        taskCollectionView.performBatchUpdates(
            {
                self.taskCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
        }, completion: { (finished:Bool) -> Void in
        })
    }
    
    
    @IBAction func addNewCollectionTask(_ sender: TransitionButton) {
        
        sender.startAnimation()
        sender.stopAnimation(animationStyle: .expand, revertAfterDelay: 0) {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddNewTaskCollectionScreen") as! AddNewCollectionViewController
            self.present(vc, animated: true, completion: nil)
        }
 
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TaskItemsTableViewController
        
        let indexPaths : NSArray = taskCollectionView.indexPathsForSelectedItems! as NSArray
        let index : IndexPath = indexPaths[0] as! IndexPath
        destination.selectedTask = App.tasks[index.row]
        
    }
    
    
}

extension TasksViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return App.tasks.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let taskCell = taskCollectionView.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath) as! TaskCollectionViewCell
        
        taskCell.delegate = self
        
        taskCell.Task = App.tasks[indexPath.row]
        
        switch App.tasks[indexPath.row].type {
            
        case Data.TaskType.SHOPPING?:
            taskCell.TaskImage.image = UIImage(named: "icon-shopping")
        case Data.TaskType.TODOLIST?:
            taskCell.TaskImage.image = UIImage(named: "icon-todo")
        default:
            taskCell.TaskImage.image = UIImage(named: "icon-todo")
        }
        
        taskCell.taskLabel.text  = App.tasks[indexPath.row].name
        taskCell.progressBar.animateTo(progress: CGFloat(App.tasks[indexPath.row].completed))
        
        
        return taskCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToItemsTask", sender: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Compute the dimension of a cell for an NxN layout with space S between
        // cells.  Take the collection view's width, subtract (N-1)*S points for
        // the spaces between the cells, and then divide by N to find the final
        // dimension for the cell's width and height.
        
        let cellsAcross: CGFloat = 2
        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim, height: dim)
    }
    

}

extension TasksViewController : TaskCollectionViewCellUpdater{
    func collectionViewUpdate() {
        taskCollectionView.reloadData()
        hideCollectionViewWhenNoData()
    }
    
    
}

