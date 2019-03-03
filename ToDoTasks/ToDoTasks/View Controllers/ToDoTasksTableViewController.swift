//
//  ToDoTasksTableViewController.swift
//  ToDoTasks
//
//  Created by Nelson Gonzalez on 2/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import CoreData

class ToDoTasksTableViewController: UITableViewController {
    
    let toDoTasksController = ToDoTasksController()
    
    lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchedRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        fetchedRequest.sortDescriptors = [NSSortDescriptor(key: "priority", ascending: true)]
        fetchedRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        let moc = CoreDataStack.shared.mainContext
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: moc, sectionNameKeyPath: "priority", cacheName: nil)
        
        fetchedResultController.delegate = self
        
        try! fetchedResultController.performFetch()
        
        return fetchedResultController
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath) as! ToDoTasksTableViewCell

       let task = fetchedResultsController.object(at: indexPath)
        
        cell.task = task
        cell.toDoTasksController = toDoTasksController

        return cell
    }
  

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let task = fetchedResultsController.object(at: indexPath)
            
            toDoTasksController.deleteTask(task: task)
  
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        guard let sectionInfo = fetchedResultsController.sections?[section] else {return nil}
        
         return sectionInfo.name.capitalized
        
//        if sectionInfo.name == "0" {
//            return "Not Done"
//        } else {
//            return "Done"
//        }
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTask" {
            let destinationVC = segue.destination as? AddToDoTaskViewController
            destinationVC?.toDoTasksController = toDoTasksController
        } else if segue.identifier == "showDetailTask" {
            let destinationVC = segue.destination as?AddToDoTaskViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let toDo = fetchedResultsController.object(at: indexPath)
            destinationVC?.toDo = toDo
            destinationVC?.toDoTasksController = toDoTasksController
        }
    }
    
    

}

extension ToDoTasksTableViewController: NSFetchedResultsControllerDelegate {
    
    //MARK: - NSFetchResultControllerDelegate
    
    //Tell the table view that were going to update
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    //tell the table were done updating
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    //a single task
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            //            tableView.deleteRows(at: [oldIndexPath], with: .automatic)
            //            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    //section related updates
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
}
