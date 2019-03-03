//
//  CoreDataStack.swift
//  ToDoTasks
//
//  Created by Nelson Gonzalez on 2/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import Foundation
import CoreData


class CoreDataStack {
    //singleton
    static let shared = CoreDataStack()
    
    private init() {}
    
    //execute closure. Whatever is returned wil be the value of this var
    //lazy means do it when it needs to be done the first time. Dont execute unless the user uses this once. When this whole class is initialized its not going to create this container.
    //Stored property will only run this code one time and store the value and wont have to recompute that every time.
    lazy var container: NSPersistentContainer = {
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        
        
        //Give container the name of the data model file.
        let container = NSPersistentContainer(name: appName)
        //Generic below doesnt work
        // let container = NSPersistentContainer(name: kCFBundleNameKey as String)
        
        //Load the persistent store. (The saved files)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    //This should help remember that the viewContext should be used on the main thread.
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
