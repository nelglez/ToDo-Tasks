//
//  ToDoTasksController.swift
//  ToDoTasks
//
//  Created by Nelson Gonzalez on 2/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData

class ToDoTasksController {
    
    init() {
        
    }
    
    func saveToPersistentStorage(){
        //Save changes to disk
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()//Save the task to the persistent store
        } catch {
            print("Error saving MOC (managed object context): \(error)")
        }
    }
    
    func createTask(title: String, notes: String, timestamp: Date = Date(), priority: TaskPriority){
         _ = Task(title: title, note: notes, priority: priority)
        
        saveToPersistentStorage()
    }
    
    func updateTask(task: Task, title: String, notes: String, timestamp: Date = Date(), priority: TaskPriority) {
        task.title = title
        task.note = notes
        task.timestamp = timestamp
        task.priority = priority.rawValue
        
        saveToPersistentStorage()
    }
    
    func updateTasksDone(task: Task, done: Bool){
        task.done = done
        
        saveToPersistentStorage()
    }

    func deleteTask(task: Task) {
        let moc = CoreDataStack.shared.mainContext
        
        moc.delete(task)
        
        saveToPersistentStorage()
    }
    
}
