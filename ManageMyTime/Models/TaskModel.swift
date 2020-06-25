//
//  TaskModel.swift
//  ManageMyTime
//
//  Created by רן א on 25/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import SwiftUI

class TaskModel
{
    
    @Environment(\.managedObjectContext) var managedObjectContext
             
           @FetchRequest(
                 entity: Task.entity(),
                 sortDescriptors: [
                     NSSortDescriptor(keyPath: \Task.taskName, ascending: true)
                 ]
             ) var tasks: FetchedResults<Task>

    func AddTask(id:UUID,taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String)
    {
        let newTask = Task(context: self.managedObjectContext)
                                 newTask.taskName = taskName
                                 newTask.importance = importance
                                 newTask.asstimatedWorkTime = asstimatedWorkTime
                                 newTask.dueDate = dueDate
                                 newTask.notes=notes
                                 newTask.id = id
                                 do {
                                  try self.managedObjectContext.save()
                                  print("Task saved.")
                                 } catch {
                                  print(error.localizedDescription)
                                  }
        
        
    }
    
    
    
    
    
}

