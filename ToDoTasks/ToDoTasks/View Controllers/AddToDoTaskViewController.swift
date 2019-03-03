//
//  ViewController.swift
//  ToDoTasks
//
//  Created by Nelson Gonzalez on 2/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class AddToDoTaskViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    
    @IBOutlet weak var addButton: UIButton!
    
    var toDoTasksController: ToDoTasksController?

    var toDo: Task? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateViews()
        taskDescriptionTextView.delegate = self
        taskTitleTextField.delegate = self
        
        appearance()
    }
    
    private func appearance() {
        addButton.layer.cornerRadius = 15
        addButton.backgroundColor = AppearanceHelper.lightBlueColor
      
    }
    
   private func updateViews(){
    
    guard isViewLoaded else {return}
    
    
    guard let toDo = toDo else {
        title = "Create Task"
        taskDescriptionTextView.text = "Please write a task description here ..."
        prioritySegmentedControl.selectedSegmentIndex = 1
        return
    }
    
    title = toDo.title
    
    taskTitleTextField.text = toDo.title
    
    taskDescriptionTextView.text = toDo.note
    
    var index: Int = 1
    
    switch toDo.priority {
    case "low":
        index = 0
    case "normal":
        index = 1
    case "high":
        index = 2
    case "critical":
        index = 3
    default:
        index = 1
    }

    prioritySegmentedControl.selectedSegmentIndex = index
    
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskDescriptionTextView.text == "Please write a task description here ..." {
            taskDescriptionTextView.text = nil
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if taskDescriptionTextView.text == nil {
            taskDescriptionTextView.text = "Please write a task description here ..."
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            taskDescriptionTextView.resignFirstResponder()
            return false
        }
        return true
    }


    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let title = taskTitleTextField.text, !title.isEmpty, let notes = taskDescriptionTextView.text, !notes.isEmpty else {
            let alert = UIAlertController(title: "Error!", message: "Please fill both task title and description field", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            
            present(alert, animated: true, completion: nil)
            return
            
        }
        
        let segmentedControlIndex = prioritySegmentedControl.selectedSegmentIndex
        
        let priority = TaskPriority.allPriorities[segmentedControlIndex]
        
        if let toDoTask = toDo {
            toDoTasksController?.updateTask(task: toDoTask, title: title, notes: notes, priority: priority)
        } else {
            toDoTasksController?.createTask(title: title, notes: notes, priority: priority)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

