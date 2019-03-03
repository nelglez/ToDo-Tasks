//
//  ToDoTasks+Convenience.swift
//  ToDoTasks
//
//  Created by Nelson Gonzalez on 2/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData

enum TaskPriority: String, CaseIterable {
    case low
    case normal
    case high
    case critical
    
    static var allPriorities: [TaskPriority] {
        return [.low, .normal, .high, .critical]
    }
}


extension Task {
    
    convenience init(title: String, note: String, timestamp: Date = Date(), done: Bool = false, priority: TaskPriority = .normal, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.title = title
        self.note = note
        self.timestamp = timestamp
        self.done = done
        self.priority = priority.rawValue
    }
}
