//
//  Task+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Proteco on 24/09/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var notes: String?
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var id_task: UUID?

}

extension Task : Identifiable {

}
