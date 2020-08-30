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

enum UUIDError: Error {
      case notConfirmedToUUID
      case badPassword
      
  }
  
  enum DatabaseError: Error {
        case taskCanNotBeScheduledInDue
      
        
    }

enum DateBoundsError: Error {
      case dueDateIsInPastTime

      
  }

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
    
    @Published var color : String
    //@Published var color : Color
    @Published var firstTaskColor:Color
    
    @Published var allTasksPerHourInWeek = [TasksPerHourPerDayOfTheWeek]()
    
    
    
  
    
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
        color=""
        startTime=Hour(context: managedContext)
        endTime=Hour(context: managedContext)
        date=CustomDate(context: managedContext)
        firstTaskColor=Color.white
        
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
    
    func completedToggle(tasdkId:UUID)
    {
        self.taskModel.completedToggle(taskId: tasdkId)
    }
    func getFirstTaskColor()
    {
        
        self.firstTaskColor=taskModel.getFirstTaskColor()
       
    }
    
    func getTaskColor(task:Task) -> Color
    {
        
        return taskModel.getTaskColor(task: task)
        
    }
    
  
    
    func createTask(taskName:String,importance:String,workTimeHours:String,workTimeMinutes:String,dueDate:Date,notes:String) throws
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
        
        do{
            try taskModel.createData(taskName: taskName,importance: importance,asstimatedWorkTime: asstimatedWorkTime,dueDate: dueDate,notes: notes)
        }
        
        catch{
            throw DatabaseError.taskCanNotBeScheduledInDue
        }
    }
    
  func autoFillTesting() throws
  {
        do{
            try taskModel.autoFillTesting()
        
        }
        catch{
            throw DatabaseError.taskCanNotBeScheduledInDue
        }
    
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
        self.color=viewModelTask.color!
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
        self.color=viewModelTask.color!
       
          
        //taskModel.retrieveAllTasks()
          
      }
    
    
    func retrieveAllTasks()
    {
        
        allTasks=taskModel.retrieveAllTasks()
        
            
        
        
    }
    
    func getTaskColor(color:String) -> Color
    {
        
        return taskModel.getTaskColor(color:color)
    }
    
    func retrieveAllDayTasks(hour:Int) ->[TasksPerHourPerDay]
    {
        return taskModel.retrieveAllDayTasks(hour:hour)
    }
    
    
    
    func retrieveAllTasksByHour(hour:Int) ->[TasksPerHourPerDay]
    {
        return taskModel.retrieveAllTasksByHour(hour:hour)
    }
    
    func retrieveAllTasksByHour(hour:Int,sequanceNum:Int) ->[TasksPerHourPerDay]
    {
        return taskModel.retrieveAllTasksByHour(hour:hour,sequanceNum:sequanceNum)
    }
    
    func retrieveAllTasksByHour()
      {
            self.allTasksPerHourInWeek=taskModel.retrieveAllTasksByHour()
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
        self.color=viewModelTask.color!
    }
    
    
 
}

