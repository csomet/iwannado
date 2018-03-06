//
//  ViewController.swift
//  iwannado
//
//  Created by Carlos Herrera Somet on 28/2/18.
//  Copyright © 2018 Carlos H Somet. All rights reserved.
//

import UIKit
import TransitionButton

class TasksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
  

    
    //MARK: - OUTLETS
    @IBOutlet weak var taskCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskCollectionView.dataSource = self
        self.taskCollectionView.delegate = self
        
       
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let taskCell = taskCollectionView.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath) as! TaskCollectionViewCell
        
        return taskCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
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
    
    
    @IBAction func addNewCollectionTask(_ sender: TransitionButton) {
        
        sender.startAnimation()
        sender.stopAnimation(animationStyle: .expand, revertAfterDelay: 0) {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddNewTaskCollectionScreen") as! AddNewCollectionViewController
            self.present(vc, animated: true, completion: nil)
        }
 
        
    }
    
}

