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

enum DaysOfTheWeek:String {
          
        case Sunday
        case Monday
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
        case Saturday
 
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
    
    @Published var color : Color
    //@Published var color : Color
    @Published var firstTaskColor:Color
    
    @Published var allTasksPerHourInWeek = [TasksPerHourPerDayOfTheWeek]()
    
    @Published var latestDayChoiseIndex:Int
    
    private var didInit:Bool
  
    private var absoluteAllTasks:[Task]
    
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
        color=Color.blue
        startTime=Hour(context: managedContext)
        endTime=Hour(context: managedContext)
        date=CustomDate(context: managedContext)
        firstTaskColor=Color.white
        latestDayChoiseIndex=0
        didInit=false
        absoluteAllTasks=[Task]()
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
    
  
    
    func createTask(taskName:String,importance:String,workTimeHours:String,workTimeMinutes:String,dueDate:Date,notes:String,color:Color=Color.green,difficultyIndex:Int) throws
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
        
        var difficultyPick="average"
        
        switch difficultyIndex {
        case 0:
            difficultyPick=difficultyLevel.difficult.rawValue
        case 1:
            difficultyPick=difficultyLevel.average.rawValue
        case 2:
            difficultyPick=difficultyLevel.easy.rawValue
        default:
            difficultyPick=difficultyLevel.average.rawValue
        }
        
        do{
            try taskModel.createData(taskName: taskName,importance: importance,asstimatedWorkTime: asstimatedWorkTime,dueDate: dueDate,notes: notes,color:color,difficulty:difficultyPick)
        }
        
        catch{
            throw DatabaseError.taskCanNotBeScheduledInDue
        }
    }
    
    func StringRangeCreator(start:Int,end:Int) -> [String]
    {
        var stringValues=[String]()
        stringValues.append("None")
        for num in start...end
        {
            stringValues.append(String(num))
   
            
        }
        
        return stringValues
   
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
        self.color=taskModel.getTaskColor(color:viewModelTask.color!)
        //taskModel.retrieveAllTasks()
          
      }
    
    func intialValuesSetup()
    {
        
        taskModel.intialValuesSetup()
        
    }
    func SetSettingsValues(scheduleAlgorithimIndex:Int,scheduleDensityIndex:Int,breakPeriodsIndex:Int,animationStyleIndex:Int)
    {
        
        var scheduleAlgorithimPick=scheduleAlgorithm.smart.rawValue
        var scheduleDensityPick=scheduleDensity.mediumDensity.rawValue
        var breakPeriodsPick=breakPeriods.hourAndAHalf.rawValue
        var animationStylePick=animationStyle.smooth.rawValue
        
        switch scheduleAlgorithimIndex {
        case 0:
            scheduleAlgorithimPick=scheduleAlgorithm.smart.rawValue
        case 1:
            scheduleAlgorithimPick=scheduleAlgorithm.optimal.rawValue
        case 2:
            scheduleAlgorithimPick=scheduleAlgorithm.advanced.rawValue
        case 3:
            scheduleAlgorithimPick=scheduleAlgorithm.earliest.rawValue
        case 4:
            scheduleAlgorithimPick=scheduleAlgorithm.latest.rawValue
        default:
            scheduleAlgorithimPick=scheduleAlgorithm.smart.rawValue
        }
        
        
        switch scheduleDensityIndex {
         case 0:
            scheduleDensityPick=scheduleDensity.verySpacious.rawValue
         case 1:
            scheduleDensityPick=scheduleDensity.spacious.rawValue
         case 2:
            scheduleDensityPick=scheduleDensity.mediumDensity.rawValue
         case 3:
            scheduleDensityPick=scheduleDensity.dense.rawValue
         case 4:
            scheduleDensityPick=scheduleDensity.veryDense.rawValue
         case 5:
            scheduleDensityPick=scheduleDensity.extremelyDense.rawValue
         case 6:
            scheduleDensityPick=scheduleDensity.maximumCapacity.rawValue
         default:
             scheduleDensityPick=scheduleDensity.mediumDensity.rawValue
         }
        
        
        switch breakPeriodsIndex {
           case 0:
              breakPeriodsPick=breakPeriods.fortyFiveMinutes.rawValue
           case 1:
              breakPeriodsPick=breakPeriods.hourAndAHalf.rawValue
           case 2:
              breakPeriodsPick=breakPeriods.twoHours.rawValue
           case 3:
              breakPeriodsPick=breakPeriods.threeHours.rawValue
           case 4:
              breakPeriodsPick=breakPeriods.fiveHours.rawValue
           case 5:
              breakPeriodsPick=breakPeriods.Continues.rawValue
           default:
               breakPeriodsPick=breakPeriods.hourAndAHalf.rawValue
           }
        
        switch animationStyleIndex {
             case 0:
                animationStylePick=animationStyle.smooth.rawValue
             case 1:
                animationStylePick=animationStyle.fast.rawValue
             case 2:
                animationStylePick=animationStyle.spring.rawValue
             default:
                animationStylePick=animationStyle.smooth.rawValue
             }
        
        
        self.taskModel.SetSettingsValues(scheduleAlgorithim: scheduleAlgorithimPick, scheduleDensity: scheduleDensityPick,breakPeriodsValue:breakPeriodsPick,animationStyleValue: animationStylePick)
        
        
    }
    
    func GetAnimationStyleSettings () -> String
    {
        return taskModel.GetAnimationStyleSettings()
        
    }
    func getSettingsValues () -> [Int]
    {
        var settingsObject=taskModel.getSettingsValues()
        
        var scheduleAlgorithmPick=0
        var scheduleDensityPick=2
        var breakPeriodsPick=1
        var animationStylePick=0
        
        switch settingsObject.scheduleAlgorithim {
        case scheduleAlgorithm.smart.rawValue:
            scheduleAlgorithmPick=0
        case scheduleAlgorithm.optimal.rawValue:
            scheduleAlgorithmPick=1
        case scheduleAlgorithm.advanced.rawValue:
            scheduleAlgorithmPick=2
        case scheduleAlgorithm.earliest.rawValue:
            scheduleAlgorithmPick=3
        case scheduleAlgorithm.latest.rawValue:
            scheduleAlgorithmPick=4
        default:
            scheduleAlgorithmPick=0
        }
        
        
        switch settingsObject.scheduleDensity {
            case scheduleDensity.verySpacious.rawValue:
                scheduleDensityPick=0
            case scheduleDensity.spacious.rawValue:
                scheduleDensityPick=1
            case scheduleDensity.mediumDensity.rawValue:
                scheduleDensityPick=2
            case scheduleDensity.dense.rawValue:
                scheduleDensityPick=3
            case scheduleDensity.veryDense.rawValue:
                scheduleDensityPick=4
            case scheduleDensity.extremelyDense.rawValue:
                scheduleDensityPick=5
            case scheduleDensity.maximumCapacity.rawValue:
                scheduleDensityPick=6
            default:
                scheduleDensityPick=2
            }
        
        switch settingsObject.breakPeriods {
                case breakPeriods.fortyFiveMinutes.rawValue:
                   breakPeriodsPick=0
                case breakPeriods.hourAndAHalf.rawValue:
                   breakPeriodsPick=1
                case breakPeriods.twoHours.rawValue:
                   breakPeriodsPick=2
                case breakPeriods.threeHours.rawValue:
                   breakPeriodsPick=3
                case breakPeriods.fiveHours.rawValue:
                   breakPeriodsPick=4
                case breakPeriods.Continues.rawValue:
                   breakPeriodsPick=5
                default:
                    breakPeriodsPick=1
                }
        switch settingsObject.animationStyle {
          case animationStyle.smooth.rawValue:
             animationStylePick=0
          case animationStyle.fast.rawValue:
             animationStylePick=1
          case animationStyle.spring.rawValue:
             animationStylePick=2
          default:
             animationStylePick=0
          }
        
        let settingsArray=[scheduleDensityPick,scheduleAlgorithmPick,breakPeriodsPick,animationStylePick]
        
        return settingsArray
        
    }
    
    func retrieveTask(taskName : String)
      {
        
        
        viewModelTask=taskModel.retrieveTask(taskName: taskName)
          
        self.taskName=viewModelTask.taskName
        self.importance=viewModelTask.importance!
        self.asstimatedWorkTime=viewModelTask.asstimatedWorkTime
        self.dueDate=viewModelTask.dueDate
        self.notes=viewModelTask.notes!
        self.color=taskModel.getTaskColor(color: viewModelTask.color!)
       
          
        //taskModel.retrieveAllTasks()
          
      }
    
    
    func retrieveAllTasks()
    {
        if(latestDayChoiseIndex != 0)//Case there is an update from the view, we should load the previous choise (if exsits) and the default all tasks scenerio
        {
            GetDayTasksByIndex(index:latestDayChoiseIndex)
        }
        else{
            if(absoluteAllTasks.isEmpty)
            {
                absoluteAllTasks=taskModel.retrieveAllTasks()
                allTasks=absoluteAllTasks
            }
            else{
                allTasks=absoluteAllTasks
            }
        }
            
        
        
    }
    
    func UpdateAllTasks()
    {
        
        absoluteAllTasks=taskModel.retrieveAllTasks()
        
        if(latestDayChoiseIndex==0)
        {
            allTasks=absoluteAllTasks
        }
        
    }
    
    func RetrieveAllTasks() -> [Task]
      {
        
        var tasks=taskModel.retrieveAllTasks()
        
        tasks.sort {
                           ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                               ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                       }
        
          
          return tasks
          
              
          
          
      }
    
    func GetDayTasksByIndex(index:Int)
    {
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        switch index {
        case 0:
            self.latestDayChoiseIndex=0
            retrieveAllTasks()
            
        case 1:
            self.latestDayChoiseIndex=1
            var dayName=DaysOfTheWeek.Sunday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
            
            
        case 2:
            self.latestDayChoiseIndex=2
             var dayName=DaysOfTheWeek.Monday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 3:
            self.latestDayChoiseIndex=3
            var dayName=DaysOfTheWeek.Tuesday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 4:
            self.latestDayChoiseIndex=4
              var dayName=DaysOfTheWeek.Wednesday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 5:
            self.latestDayChoiseIndex=5
             var dayName=DaysOfTheWeek.Thursday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 6:
            self.latestDayChoiseIndex=6
             var dayName=DaysOfTheWeek.Friday.rawValue.lowercased()
             var tasks=taskModel.retrieveAllTasks()
                 
                 tasks.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                    ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                            }
            let endOfWeek = CustomDate(context: managedContext)
                endOfWeek.year=Date().endOfWeek.year
                endOfWeek.month=Date().endOfWeek.month
                endOfWeek.day=Date().endOfWeek.day
            var matchingTasks = [Task]()
            for task in tasks{
                if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                {
                    matchingTasks.append(task)
                }
            }
            
            allTasks=matchingTasks
        case 7:
            self.latestDayChoiseIndex=7
               var dayName=DaysOfTheWeek.Saturday.rawValue.lowercased()
               var tasks=taskModel.retrieveAllTasks()
                   
                   tasks.sort {
                                  ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                                      ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                              }
              let endOfWeek = CustomDate(context: managedContext)
                  endOfWeek.year=Date().endOfWeek.year
                  endOfWeek.month=Date().endOfWeek.month
                  endOfWeek.day=Date().endOfWeek.day
               
              var matchingTasks = [Task]()
              for task in tasks{
                  if (task.date.dayOfWeek().lowercased()==dayName && task.date <= endOfWeek )
                  {
                      matchingTasks.append(task)
                  }
              }
              
              allTasks=matchingTasks
        default:
             retrieveAllTasks()
        }
        
        
        
        
    }
    
    func GetTasksByDatesSeparation() -> [TasksAndDates]
    {
        var tasks=taskModel.retrieveAllTasks()
             
             tasks.sort {
                        ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                            ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                    }
        var separatedTasks=[TasksAndDates]()
       
        var tempTaskArray=[Task]()
        
        var latestIndexCatalyst=0
        if(!tasks.isEmpty)
        {
            for index in 0...tasks.count-1{
                
              
                
                if(index != 0 && tasks[index-1].date != tasks[index].date )
                {
                    if(tasks[index].date.day==25)
                    {
                        
                        print("ok separated")
                    }
                    for secIndex in latestIndexCatalyst...index-1
                    {
                        tempTaskArray.append(tasks[secIndex])
                        
                    }
                    latestIndexCatalyst=index
                    separatedTasks.append(TasksAndDates(date:tasks[index-1].date,tasks:tempTaskArray))
                    tempTaskArray=[]
                }
                
                if(index == tasks.count-1)
                {
                    for secIndex in latestIndexCatalyst...index
                    {
                           tempTaskArray.append(tasks[secIndex])
                           
                    }
                   latestIndexCatalyst=index
                   separatedTasks.append(TasksAndDates(date:tasks[index].date,tasks:tempTaskArray))
                   tempTaskArray=[]
                      
                }
                
            }
        }
        return separatedTasks
        
        
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
    
    func UpdateData(id:UUID,newTaskName : String, newNotes : String,color:Color ){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
        

        
        taskModel.UpdateData(id: id, newTaskName: newTaskName, newNotes: newNotes, color: color.description)
          
      }
    

    
    
    func deleteTask(taskId : UUID){
    
        taskModel.deleteTask(taskId : taskId)
        self.UpdateAllTasks()
         self.GetDayTasksByIndex(index: latestDayChoiseIndex)//In order to update the published task array after deletion
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
        self.color=taskModel.getTaskColor(color: viewModelTask.color!) 
    }
    
    
 
}

