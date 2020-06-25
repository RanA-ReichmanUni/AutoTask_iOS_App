//
//  Task+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 24/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension Task: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var taskName: String?
    @NSManaged public var active: Bool
    @NSManaged public var completed: Bool
    @NSManaged public var importance: String
    @NSManaged public var notes: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var asstimatedWorkTime: Int32
    
    var taskImportance: TaskImportance {
        set {importance = newValue.rawValue}
        get {TaskImportance(rawValue: importance) ?? .medium}
    }

}

enum TaskImportance:String {
    
  case veryHigh
  case high
  case medium
  case low
  case veryLow
    
}
