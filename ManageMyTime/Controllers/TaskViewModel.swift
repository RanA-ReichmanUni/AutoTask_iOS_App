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
    
    
    private var ViewModelTask = Task()
    
  
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
        taskName=""
        importance=""
        asstimatedWorkTime=0
        dueDate=Date()
        notes=""
         
     }
    
    func CreateTask(taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String)
    {
        
        ViewModelTask.setValue(taskName, forKeyPath: "taskName")
        ViewModelTask.setValue(importance, forKeyPath: "importance")
        ViewModelTask.setValue(asstimatedWorkTime, forKeyPath: "asstimatedWorkTime" )
        ViewModelTask.setValue(dueDate, forKeyPath: "dueDate")
        ViewModelTask.setValue(notes, forKeyPath: "notes")
            
        self.taskName=ViewModelTask.taskName as! String
        self.importance=ViewModelTask.importance
        self.asstimatedWorkTime=ViewModelTask.asstimatedWorkTime
        self.dueDate=ViewModelTask.dueDate
        self.notes=ViewModelTask.notes as! String
        
        taskModel.createData(taskName: taskName,importance: importance,asstimatedWorkTime: asstimatedWorkTime,dueDate: dueDate,notes: notes)
        
    }
    

    func retrieveTask(taskID : String) throws
      {
        let taskUUID = UUID(uuidString: taskID) ?? UUID()
    
       
        
       if taskUUID.uuidString != taskID
       {
            throw UUIDError.notConfirmedToUUID
       }
        

         ViewModelTask=taskModel.retrieveTask(taskID: taskUUID)
          
        self.taskName=ViewModelTask.taskName as! String
        self.importance=ViewModelTask.importance
        self.asstimatedWorkTime=ViewModelTask.asstimatedWorkTime
        self.dueDate=ViewModelTask.dueDate
        self.notes=ViewModelTask.notes as! String
        
        //taskModel.retrieveAllTasks()
          
      }
    
    
    func retrieveTask(taskName : String)
      {
        
        
        ViewModelTask=taskModel.retrieveTask(taskName: taskName)
          
        self.taskName=ViewModelTask.taskName as! String
        self.importance=ViewModelTask.importance
        self.asstimatedWorkTime=ViewModelTask.asstimatedWorkTime
        self.dueDate=ViewModelTask.dueDate
        self.notes=ViewModelTask.notes as! String
        
       
          
        //taskModel.retrieveAllTasks()
          
      }
    
    
    func retrieveAllTasks()
    {
        
        taskModel.retrieveAllTasks()
        
    }
    
     func updateData(orginalTaskName : String,newTaskName : String, newImportance : String,newAsstimatedWorkTime :Int32, newDueDate : Date, newNotes : String ){
        
        taskModel.updateData(orginalTaskName: orginalTaskName, newTaskName: newTaskName, newImportance: newImportance, newAsstimatedWorkTime: newAsstimatedWorkTime, newDueDate: newDueDate, newNotes: newNotes)
        
    }
    
    
    func deleteTask(taskName : String){
    
        taskModel.deleteTask(taskName : taskName)
        
    }
}

