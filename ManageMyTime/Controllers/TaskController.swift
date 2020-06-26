//
//  TaskController.swift
//  ManageMyTime
//
//  Created by רן א on 25/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData


class TaskController
{
    
    var taskModel = TaskModel()
    
    
    func createTask(taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String)
    {
        
        taskModel.createData(taskName: taskName,importance: importance,asstimatedWorkTime: asstimatedWorkTime,dueDate: dueDate,notes: notes)
        
    }
    
    
    func retrieveTask()
      {
          
        taskModel.retrieveData()
          
      }
      
    
    
}

