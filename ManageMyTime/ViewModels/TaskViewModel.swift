//
//  TaskController.swift
//  ManageMyTime
//
//  Created by רן א on 25/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData




class TaskViewModel : ObservableObject
{
    
    
    private var viewModelTask : Task
    
    @Published var allTasks = [Task]()
    
    @Published var taskName : String
    
    @Published var importance : String
    
    @Published var asstimatedWorkTime : Int32
    
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
        asstimatedWorkTime=0
        dueDate=Date()
        notes="None"
        allTasks=[]
        viewModelTask=Task()
     }
    
    func createTask(taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String)
    {
       
  
            
        self.taskName=taskName
        self.importance=importance
        self.asstimatedWorkTime=asstimatedWorkTime
        self.dueDate=dueDate
        self.notes=notes
        
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
          
        self.taskName=viewModelTask.taskName as! String
        self.importance=viewModelTask.importance
        self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        self.dueDate=viewModelTask.dueDate
        self.notes=viewModelTask.notes as! String
        
        //taskModel.retrieveAllTasks()
          
      }
    
    
    func retrieveTask(taskName : String)
      {
        
        
        viewModelTask=taskModel.retrieveTask(taskName: taskName)
          
        self.taskName=viewModelTask.taskName as! String
        self.importance=viewModelTask.importance
        self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        self.dueDate=viewModelTask.dueDate
        self.notes=viewModelTask.notes as! String
        
       
          
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
         self.retrieveAllTasks()
    }
}

