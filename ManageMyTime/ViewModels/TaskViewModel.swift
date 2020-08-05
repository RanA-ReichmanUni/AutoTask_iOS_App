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
import SwiftUI


class TaskViewModel : ObservableObject
{
    
    
    private var viewModelTask : Task
    
    @Published var allTasks = [Task]()
    
    @Published var taskName : String
    
    @Published var importance : String
    
    @Published var startTime : Hour
    
    @Published var endTime : Hour
    
    @Published var date : CustomDate
    
    @Published var asstimatedWorkTime : Hour
    
    @Published var dueDate : Date
    
    @Published var notes : String
    
    @Published var id : UUID
    
    //@Published var color : Color

    
    enum UUIDError: Error {
        case notConfirmedToUUID
        case badPassword
    }
    
    var taskModel = TaskModel()
    

    
    
     init()
     {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
                         
                         //We need to create a context from this container
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        taskName="Default"
        importance="Medium"
        asstimatedWorkTime=Hour(context: managedContext)

        dueDate=Date()
        notes="None"
        //allTasks=[]
        viewModelTask=Task()
        //color=Color(.systemTeal)
        id=UUID()
        startTime=Hour(context: managedContext)
        endTime=Hour(context: managedContext)
        date=CustomDate(context: managedContext)
        
        asstimatedWorkTime.hour=0
        asstimatedWorkTime.minutes=0
        startTime.hour=0
        startTime.minutes=0
        endTime.hour=0
        endTime.minutes=0
        
        date.day=0
        date.month=0
        date.year=0
        
        //retrieveAllTasks()
    
     }
    
    func getTaskColor(task:Task) -> Color
    {
        
        return taskModel.getTaskColor(task: task)
        
    }
    
    func createTask(taskName:String,importance:String,workTimeHours:String,workTimeMinutes:String,dueDate:Date,notes:String)
    {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        self.taskName=taskName
        self.importance=importance
        self.dueDate=dueDate
        self.notes=notes
        asstimatedWorkTime=Hour(context: managedContext)
        self.asstimatedWorkTime.hour=Int(workTimeHours) ?? 0
        self.asstimatedWorkTime.minutes=Int(workTimeMinutes) ?? 30
        
        
        taskModel.createData(taskName: taskName,importance: importance,asstimatedWorkTime: asstimatedWorkTime,dueDate: dueDate,notes: notes)
        
    }
    
  func autoFillTesting()
  {
    taskModel.autoFillTesting()
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
    
    
    
    func retrieveAllDayTasks(hour:Int) ->[TasksPerHourPerDay]
    {
        return taskModel.retrieveAllDayTasks(hour:hour)
    }
    
    
    func retrieveAllTasksByHour(hour:Int) ->[TasksPerHourPerDay]
    {
        return taskModel.retrieveAllTasksByHour(hour:hour)
    }
    
     func updateData(orginalTaskName : String,newTaskName : String, newImportance : String,newAsstimatedWorkTime :Int32, newDueDate : Date, newNotes : String ){
        
        taskModel.updateData(orginalTaskName: orginalTaskName, newTaskName: newTaskName, newImportance: newImportance, newAsstimatedWorkTime: newAsstimatedWorkTime, newDueDate: newDueDate, newNotes: newNotes)
        
    }
    
    
    func deleteTask(taskId : UUID){
    
        taskModel.deleteTask(taskId : taskId)
         self.retrieveAllTasks()//In order to update the published task array after deletion
    }
    
    func getTask(taskId:UUID)
    {
        
        viewModelTask=taskModel.retrieveTask(taskID: taskId)
        
        self.taskName=viewModelTask.taskName
        self.importance=viewModelTask.importance!
        self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        print(viewModelTask.asstimatedWorkTime)
        self.dueDate=viewModelTask.dueDate
        self.notes=viewModelTask.notes!
        self.date=viewModelTask.date
        self.startTime=viewModelTask.startTime!
        self.endTime=viewModelTask.endTime!
        self.id=viewModelTask.id
        
    }
    
    
 
}

