//
//  TaskController.swift
//  ManageMyTime
//
//  Created by רן א on 25/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData
import UIKit



class TaskViewModel : ObservableObject
{
    
    
    private var viewModelTask : Task
    
    @Published var allTasks = [Task]()
    
    @Published var taskName : String
    
    @Published var importance : String
    
    @Published var asstimatedWorkTime : Hour
    
    @Published var dueDate : Date
    
    @Published var notes : String
    


    
    enum UUIDError: Error {
        case notConfirmedToUUID
        case badPassword
    }
    
    var taskModel = TaskModel()
    
    
     init()
     {
     
        taskName="Default"
        importance="Medium"
        asstimatedWorkTime=Hour()
        dueDate=Date()
        notes="None"
        allTasks=[]
        viewModelTask=Task()
     }
    
    func createTask(taskName:String,importance:String,workTimeHours:Int,workTimeMinutes:Int,dueDate:Date,notes:String)
    {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        self.taskName=taskName
        self.importance=importance
        self.dueDate=dueDate
        self.notes=notes
        asstimatedWorkTime=Hour(context: managedContext)
        self.asstimatedWorkTime.hour=workTimeHours
        self.asstimatedWorkTime.minutes=workTimeMinutes
        
        
        taskModel.createData(taskName: taskName,importance: importance,asstimatedWorkTime: asstimatedWorkTime,dueDate: dueDate,notes: notes)
        
    }
    
  

    func retrieveTask(taskID : String) throws
      {
        let taskUUID = UUID(uuidString: taskID) ?? UUID()
    
       
        
       if taskUUID.uuidString != taskID
       {
            throw UUIDError.notConfirmedToUUID
       }
        

         viewModelTask=taskModel.retrieveTask(taskID: taskUUID)
          
        self.taskName=viewModelTask.taskName
        self.importance=viewModelTask.importance!
        self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        self.dueDate=viewModelTask.dueDate
        self.notes=viewModelTask.notes!
        
        //taskModel.retrieveAllTasks()
          
      }
    
    
    func retrieveTask(taskName : String)
      {
        
        
        viewModelTask=taskModel.retrieveTask(taskName: taskName)
          
        self.taskName=viewModelTask.taskName
        self.importance=viewModelTask.importance!
        self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        self.dueDate=viewModelTask.dueDate
        self.notes=viewModelTask.notes!
        
       
          
        //taskModel.retrieveAllTasks()
          
      }
    
    
    func retrieveAllTasks()
    {
        
        allTasks=taskModel.retrieveAllTasks()
        
            
        
        
    }
    
     func updateData(orginalTaskName : String,newTaskName : String, newImportance : String,newAsstimatedWorkTime :Int32, newDueDate : Date, newNotes : String ){
        
        taskModel.updateData(orginalTaskName: orginalTaskName, newTaskName: newTaskName, newImportance: newImportance, newAsstimatedWorkTime: newAsstimatedWorkTime, newDueDate: newDueDate, newNotes: newNotes)
        
    }
    
    
    func deleteTask(taskName : String){
    
        taskModel.deleteTask(taskName : taskName)
         self.retrieveAllTasks()//In order to update the published task array after deletion
    }
}

