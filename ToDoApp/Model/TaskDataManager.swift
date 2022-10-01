//
//  TaskDataManager.swift
//  ToDoApp
//
//  Created by Proteco on 24/09/22.
//

import Foundation
import CoreData

class TaskDataManager{
    private var tasks: [Task] = []
    private var mObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.mObjectContext = context
    }
    
    func fetch() -> [Task] {
        do {
            self.tasks = try self.mObjectContext.fetch(Task.fetchRequest())
            return tasks
        }catch {
            print("ERROR: ", error)
            return []
        }
    }
    
    func getTaskAtIndex(index: Int) -> Task {
        return tasks[index]
    }
    
    func countTasks() -> Int {
        return tasks.count
    }
    
}
