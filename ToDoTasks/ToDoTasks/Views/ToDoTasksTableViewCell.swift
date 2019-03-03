//
//  ToDoTasksTableViewCell.swift
//  ToDoTasks
//
//  Created by Nelson Gonzalez on 2/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ToDoTasksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    var toDoTasksController: ToDoTasksController?
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func updateViews() {
        guard let task = task else {return}
        
        todoTitleLabel.text = task.title
        guard let timeStamp = task.timestamp else {return}
        let dateString = String.dateToString(date: timeStamp)
        dateCreatedLabel.text = dateString
       
        if task.done == true {
            doneButton.setImage(UIImage(named: "checkbox_filled"), for: .normal)
        } else {
            doneButton.setImage(UIImage(named: "checkbox"), for: .normal)
        }
    }
  
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        guard let task = task else {return}
        
        if task.done == false {
            task.done = true
            toDoTasksController?.updateTasksDone(task: task, done: true)
            updateViews()
        } else {
            task.done = false
            toDoTasksController?.updateTasksDone(task: task, done: false)
            updateViews()
        }
    }
    
}
