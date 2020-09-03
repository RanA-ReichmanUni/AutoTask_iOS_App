//
//  Task+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 02/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }



       @NSManaged public var active: Bool
       @NSManaged public var color: String?
       @NSManaged public var completed: Bool
       @NSManaged public var dueDate: Date
       @NSManaged public var id: UUID
       @NSManaged public var importance: String?
       @NSManaged public var isTaskBreakWindow: Bool
       @NSManaged public var notes: String?
       @NSManaged public var taskName: String
       @NSManaged public var internalId: UUID?
       @NSManaged public var asstimatedWorkTime: Hour
       @NSManaged public var date: CustomDate
       @NSManaged public var endTime: Hour?
       @NSManaged public var startTime: Hour?
       @NSManaged public var scheduleSection: String

       
       var taskImportance: TaskImportance {
                  set {importance = newValue.rawValue}
                  get {TaskImportance(rawValue: importance!) ?? .medium}
              }
              
           

          }

          enum TaskImportance:String {
              
            case veryHigh
            case high
            case medium
            case low
            case veryLow
              
          }
