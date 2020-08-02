//
//  TaskModel.swift
//  ManageMyTime
//
//  Created by רן א on 25/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

class TaskModel : UIViewController
{
    var coreManagment = Core()
    //var allTasks = [Task]()
    
    
    func getTaskColor (task:Task) -> Color
    {
        
        switch task.color {
        case "Red":
            return Color(.systemRed)
        case "Teal":
            return Color(.systemTeal)
        case "Green":
            return Color(.systemGreen)
        case "Orange":
            return Color(.systemOrange)
        case "Pink":
            return Color(.systemPink)
        case "Blue":
            return Color(.systemBlue)
        case "Indigo":
            return Color(.systemIndigo)
        default:
            return Color(.systemTeal)
        }
        
        
    }
    
    func autoFillTesting()
    {

        
        let taskName = ["Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger","Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger","Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger","Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger","Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger"]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext


        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 8
        dateComponents.day = 8


        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let someDateTime = userCalendar.date(from: dateComponents)
        
        let colorArray = ["Green","Teal","Pink","Red","Orange","Blue","Indigo"].shuffled()
       
        let startTime=Hour(context: managedContext)
            startTime.hour=7
            startTime.minutes=0
        let endTime=Hour(context: managedContext)
            endTime.hour=15
            endTime.minutes=0
        
        createRestrictedSpace(startTime: startTime,endTime: endTime,dayOfTheWeek: "Wednesday")
        
        
        let startTime2=Hour(context: managedContext)
            startTime2.hour=12
            startTime2.minutes=0
        let endTime2=Hour(context: managedContext)
            endTime2.hour=15
            endTime2.minutes=0
        
        createRestrictedSpace(startTime: startTime2,endTime: endTime2,dayOfTheWeek: "Friday")
        
        
       let startTime3=Hour(context: managedContext)
                startTime3.hour=8
                startTime3.minutes=0
            let endTime3=Hour(context: managedContext)
                endTime3.hour=11
                endTime3.minutes=0
            
            createRestrictedSpace(startTime: startTime3,endTime: endTime3,dayOfTheWeek: "Friday")
        
        
        let startTime4=Hour(context: managedContext)
                   startTime4.hour=11
                   startTime4.minutes=0
               let endTime4=Hour(context: managedContext)
                   endTime4.hour=13
                   endTime4.minutes=0
               
              createRestrictedSpace(startTime: startTime4,endTime: endTime4,dayOfTheWeek: "Saturday")
        for name in taskName
        {
            //Critical error in the notation example code, this is the same hour each time in the context that is being saved repeaditly ! , meaning that asstimatedWorkTime changes to the last tasks asstimatedWorkTime random value, create a new Object to fix it !
            
            
           /* asstimatedWorkTime.hour=Int.random(in: 3 ... 5)
            asstimatedWorkTime.minutes=Int.random(in: 0 ... 59)*/
            
            
            let asstimatedWorkTime=Hour(context: managedContext)
                    asstimatedWorkTime.hour=Int.random(in: 3 ... 5)
                    asstimatedWorkTime.minutes=Int.random(in: 0 ... 59)
            
            coreManagment.ScheduleTask(taskName: name, importance: "Very High", asstimatedWorkTime: asstimatedWorkTime, dueDate: someDateTime!, notes: "Hi",color:colorArray[Int.random(in: 0 ... 6)])
            
            
            do {
                      try managedContext.save()
                          print("Saved Task !.")
                  } catch let error as NSError {
                      print("Could not save. \(error), \(error.userInfo)")
                  }
        }
        

        
    }
    func createData(taskName:String,importance:String,asstimatedWorkTime:Hour,dueDate:Date,notes:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        coreManagment.ScheduleTask(taskName: taskName, importance: importance, asstimatedWorkTime: asstimatedWorkTime, dueDate: dueDate, notes: notes,color:"Pink")
            
            /*let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
            task.setValue(retrivedTask.taskName, forKeyPath: "taskName")
            task.setValue(retrivedTask.importance, forKeyPath: "importance")
            task.setValue(retrivedTask.asstimatedWorkTime, forKeyPath: "asstimatedWorkTime")
            task.setValue(retrivedTask.dueDate, forKeyPath: "dueDate")
            task.setValue(retrivedTask.notes, forKeyPath: "notes")
            task.setValue(retrivedTask.startTime, forKeyPath: "startTime")
            task.setValue(retrivedTask.date, forKeyPath: "date")
            task.setValue(retrivedTask.endTime, forKeyPath: "endTime")
            task.setValue(retrivedTask.completed, forKeyPath: "completed")
            task.setValue(retrivedTask.color, forKeyPath: "color")
            task.setValue(retrivedTask.active, forKeyPath: "active")
            task.setValue(UUID(), forKeyPath: "id")*/
        

        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
                print("Saved Task !.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func createRestrictedSpace(startTime: Hour,endTime: Hour,dayOfTheWeek: String)
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        

        
        let restrictedSpace = RestrictedSpace(context: managedContext)
        
        restrictedSpace.startTime=startTime
        restrictedSpace.endTime=endTime
        restrictedSpace.dayOfTheWeek=dayOfTheWeek
        restrictedSpace.id=UUID()
        
      //  coreManagment.createDayFreeSpace(restrictedStartTime: startTime, restrictedEndTime: endTime, dayOfTheWeek: dayOfTheWeek)

        do {
                 try managedContext.save()
                     print("Saved RestrictedSpace.")
             } catch let error as NSError {
                 print("Could not save. \(error), \(error.userInfo)")
             }
        
        
    }
    
    
    func retrieveTask(taskID : UUID) -> Task {
                              
                  let emptyTask = Task ()
        
                  //As we know that container is set up in the AppDelegates so we need to refer that container.
                  guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return emptyTask }
                  
                  //We need to create a context from this container
                  let managedContext = appDelegate.persistentContainer.viewContext
                  
                  let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
                 fetchRequest.predicate = NSPredicate(format: "id = %@", taskID as CVarArg)
                  do
                  {
                      let requiredTask = try managedContext.fetch(fetchRequest)
             
                          let retrievedObject = requiredTask[0] as! Task
                       
                    print("Name:",retrievedObject.taskName as! String)
                    
                      return retrievedObject
                  }
                    
                  catch
                  {
                      print(error)
                  }
        
            //Shouldn't get here theoretically
            return emptyTask
        }
    
    func retrieveTask(taskName : String) -> Task {
                                 
                     let emptyTask = Task ()
           
                     //As we know that container is set up in the AppDelegates so we need to refer that container.
                     guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return emptyTask }
                     
                     //We need to create a context from this container
                     let managedContext = appDelegate.persistentContainer.viewContext
                     
                     let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
                    fetchRequest.predicate = NSPredicate(format: "taskName = %@", taskName as CVarArg)
                     do
                     {
                         let requiredTask = try managedContext.fetch(fetchRequest)
                
                             let retrievedObject = requiredTask[0] as! Task
                          
                       print("Name:",retrievedObject.taskName as! String)
                       
                         return retrievedObject
                     }
                       
                     catch
                     {
                         print(error)
                     }
           
               //Shouldn't get here theoretically
               return emptyTask
           }
    
    
    func retrieveAllTasks() -> [Task] {
           var allTasks=[Task]()
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasks }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
            do {
                
                let result = try managedContext.fetch(fetchRequest)
                for data in result as! [Task] {
                        
                    if(data.taskName=="Task King")
                    {
                            print("Task Status: ")
                            print(data.taskName)
                            print("Duration ",data.asstimatedWorkTime.hour,":",data.asstimatedWorkTime.minutes)
                            print("Start Time ",data.startTime!.hour,":",data.startTime!.minutes)
                            print("End Time ",data.endTime!.hour,":",data.endTime!.minutes)
                    }
                    
                        allTasks.append(data)
                    /*    print(data.taskName)
                    print(data.asstimatedWorkTime.hour,":",data.asstimatedWorkTime.minutes)
                    print(data.startTime!.hour,":",data.startTime!.minutes)
                    print(data.endTime!.hour,":",data.endTime!.minutes)*/
                    
                    /*print("Name:",data.value(forKey: "taskName") as! String," Importance:",data.value(forKey: "importance") as! String," Id:",data.value(forKey: "id") as! UUID )*/
               
                }
                print("Retrived all tasks !")
                
            } catch {
                
                print("Failed")
            }
        
        return allTasks
        }
    
    func retrieveAllDayTasks(hour:Int) -> [TasksPerHourPerDay] {
        
        
              var allTasks=[TasksPerHourPerDay]()
              
          
              //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasks }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              
              //Prepare the request of type NSFetchRequest  for the entity
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
          
        fetchRequest.predicate = NSPredicate(format: "date.year = %@ AND date.month = %@ AND date.day = %@", argumentArray: [Date().year,Date().month,Date().day])
                  
              let nextHour = Hour(context: managedContext)
                  nextHour.hour=hour+1
                  nextHour.minutes=0
              
              let beginningOfHour = Hour(context: managedContext)
              beginningOfHour.hour=hour
              beginningOfHour.minutes=0
              
                 // let weekSequence=coreManagment.createCalanderSequence(startDay: 26, startMonth: 7, startYear: 2020, endDay: 1, endMonth: 8, endYear: 2020)
          //        fetchRequest.fetchLimit = 1
          //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
          //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
          //
                  do {
                      
                      var result = try managedContext.fetch(fetchRequest) as! [Task]
                      
                      result.sort {
                          ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour) <
                              ($1.date.year,$1.date.month,$1.date.day,$0.startTime!.hour)
                      }
                      
                        //  var tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                      
                      var tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                   
                              if(result.contains(where: {(($0.startTime! == beginningOfHour) || ($0.startTime! <= beginningOfHour && $0.endTime! > beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! < nextHour) || ($0.startTime! > beginningOfHour && $0.endTime! <  beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! > beginningOfHour && $0.startTime!.hour==hour) || ($0.endTime! > beginningOfHour && $0.startTime!.hour < hour))}))
                              {
                                  let data = result.all(where: { (($0.startTime! == beginningOfHour) || ($0.startTime! <= beginningOfHour && $0.endTime! > beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! < nextHour) || ($0.startTime! > beginningOfHour && $0.endTime! <  beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! > beginningOfHour && $0.startTime!.hour==hour) || ($0.endTime! > beginningOfHour && $0.startTime!.hour < hour)) })

                                 tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                                  
                                  tasksPerHourPerDay.isEmptySlot=false
                                  
                                  
                                  var heightFactor=CGFloat(1.6)
                                  
                                  if(data.count > 1)
                                  {
                                      heightFactor=1.9
                                      
                                      
                                      for task in data{
                                                               
                                          tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: task.taskName,color:getTaskColor(task: task)))
                    
                                      }
                                                           
                                  }
                                  /*else{
                                      heightFactor=1.6
                                  }*/
                                  else{
                                      
                                     /* if(data[0].startTime! > beginningOfHour)
                                       {
                                          tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white)))
                                       }
                                      */
                                    if(data[0].endTime! < nextHour && data[0].endTime!.minutes > 45)
                                    {
                                        tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: CGFloat(1.5) , taskName: data[0].taskName,color:getTaskColor(task: data[0])))
                                              //Multiple tasks per hour
                                    }
                                    else if(data[0].endTime! < nextHour && data[0].endTime!.minutes < 30)
                                    {
                                        tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: CGFloat(1) , taskName: data[0].taskName,color:getTaskColor(task: data[0])))
                                                                                 //Multiple tasks per hour
                                    }
                                    else{
                                         tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: data[0].taskName,color:getTaskColor(task: data[0])))
                                    }
                                      
                                  /*    if(data[0].endTime! < nextHour)
                                       {
                                            tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white)))
                                       }*/
                                      
                                      
                                  }
                           
                
                                
                              }
                              else{//Case it's an empty hour for that day (index)
                                  tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: true, tasks: [TaskPerHour]())
                                  //tasksPerHourPerDay.isEmptySlot=true
                              }
                              
                              allTasks.append(tasksPerHourPerDay)//Tasks per hour
                             
                              tasksPerHourPerDay.tasks=[]
                          
                          
                      
                         
                              //allTasks.append(TasksByHour(data)
                              
                         // allTasks.append(tasksByHour)//All hours of the week followed each by all the appropriate tasks for each hour for the week
                          
                       /*   for data in allTasks
                          {
                              
                              print(data.hour)
                              for oneString in data.tasks
                              {
                                  print(oneString)
                              }
                              print("-----")
                          }*/
                          /*print("Name:",data.value(forKey: "taskName") as! String," Importance:",data.value(forKey: "importance") as! String," Id:",data.value(forKey: "id") as! UUID )*/
                     
                      
                      print("Retrived all tasks !")
                      
                    }       catch {
                      
                      print("Failed")
                  }
              
              return allTasks
    }
    
     func retrieveAllTasksByHour(hour:Int) -> [TasksPerHourPerDay] {
              
           var allTasks=[TasksPerHourPerDay]()
           var coreManagment=Core()
       
           let startOfDay=7
           let endOfDay=24
       
           //As we know that container is set up in the AppDelegates so we need to refer that container.
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasks }
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
           
           //Prepare the request of type NSFetchRequest  for the entity
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
       
           fetchRequest.predicate = NSPredicate(format: "date.year >= %@", argumentArray: [Date().year])
               
           let nextHour = Hour(context: managedContext)
               nextHour.hour=hour+1
               nextHour.minutes=0
           
           let beginningOfHour = Hour(context: managedContext)
           beginningOfHour.hour=hour
           beginningOfHour.minutes=0
           
               let weekSequence=coreManagment.createCalanderSequence(startDay: 2, startMonth: 8, startYear: 2020, endDay: 8, endMonth: 8, endYear: 2020)
       //        fetchRequest.fetchLimit = 1
       //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
       //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
       //
               do {
                   
                   var result = try managedContext.fetch(fetchRequest) as! [Task]
                   
                   result.sort {
                       ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour,$0.startTime!.minutes) <
                           ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour,$1.startTime!.minutes)
                   }
                   
                     //  var tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                   
                   var tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                       for dayOfTheWeek in weekSequence
                       {
                           if(result.contains(where: { dayOfTheWeek.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day)  && (($0.startTime! == beginningOfHour) || ($0.startTime! <= beginningOfHour && $0.endTime! > beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! < nextHour) || ($0.startTime! > beginningOfHour && $0.endTime! <  beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! > beginningOfHour && $0.startTime!.hour==hour) || ($0.endTime! > beginningOfHour && $0.startTime!.hour < hour))}))
                           {
                               let data = result.all(where: { dayOfTheWeek.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day) && (($0.startTime! == beginningOfHour) || ($0.startTime! <= beginningOfHour && $0.endTime! > beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! < nextHour) || ($0.startTime! > beginningOfHour && $0.endTime! <  beginningOfHour) || ($0.startTime! > beginningOfHour && $0.endTime! > beginningOfHour && $0.startTime!.hour==hour) || ($0.endTime! > beginningOfHour && $0.startTime!.hour < hour)) })

                              tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: false, tasks: [TaskPerHour]())
                               
                               tasksPerHourPerDay.isEmptySlot=false
                               
                               
                               var heightFactor=CGFloat(1.6)
                               
                               if(data.count > 1)
                               {
                                   heightFactor=1.9
                                   
                                   
                                   for task in data{
                                                            
                                       tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: task.taskName,color:getTaskColor(task: task)))
                 
                                   }
                                                        
                               }
                               /*else{
                                   heightFactor=1.6
                               }*/
                               else{
                                   
                                   if(data[0].startTime! > beginningOfHour)
                                    {
                                       tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white)))
                                    }
                                   
                                   tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: data[0].taskName,color:getTaskColor(task: data[0])))
                                           //Multiple tasks per hour
                                   
                                   if(data[0].endTime! < nextHour)
                                    {
                                         tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white)))
                                    }
                                   
                                   
                               }
                        
             
                             
                           }
                           else{//Case it's an empty hour for that day (index)
                               tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: true, tasks: [TaskPerHour]())
                               //tasksPerHourPerDay.isEmptySlot=true
                           }
                           
                           allTasks.append(tasksPerHourPerDay)//Tasks per hour
                          
                           tasksPerHourPerDay.tasks=[]
                       }
                       
                   
                      
                           //allTasks.append(TasksByHour(data)
                           
                      // allTasks.append(tasksByHour)//All hours of the week followed each by all the appropriate tasks for each hour for the week
                       
                    /*   for data in allTasks
                       {
                           
                           print(data.hour)
                           for oneString in data.tasks
                           {
                               print(oneString)
                           }
                           print("-----")
                       }*/
                       /*print("Name:",data.value(forKey: "taskName") as! String," Importance:",data.value(forKey: "importance") as! String," Id:",data.value(forKey: "id") as! UUID )*/
                  
                   
                   print("Retrived all tasks !")
                   
               } catch {
                   
                   print("Failed")
               }
           
           return allTasks
           }
    
    func getAllDailyLoads() -> [LoadLevel]
    {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [LoadLevel]()}
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
        
           let currentDate = CustomDate(context:managedContext)
            currentDate.year=Date().year
            currentDate.month=Date().month
            currentDate.day=Date().day
        
        
           let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "LoadLevel")
                                                 
                             
               fetchRequest.predicate = NSPredicate(format: "date >= %@", argumentArray: [currentDate])
                                                       
               var loadLevels = [LoadLevel]()
                   
                 do
                 {
                     let results = try managedContext.fetch(fetchRequest)
                     
               
                         
                         
                       for result in results as! [NSManagedObject] {

                             let spaceObj = result as! LoadLevel
                         
                             loadLevels.append(spaceObj)
                             
                        }
                 }
                 catch
                 {
                     print(error)
                 }
                   
        
                return loadLevels
    
    
    }
    
    func updateData(orginalTaskName : String,newTaskName : String, newImportance : String,newAsstimatedWorkTime : Int32, newDueDate : Date, newNotes : String ){
     
         //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
         fetchRequest.predicate = NSPredicate(format: "taskName = %@", orginalTaskName)
         do
         {
             let requiredTask = try managedContext.fetch(fetchRequest)
    
                 let objectUpdate = requiredTask[0] as! NSManagedObject
                 objectUpdate.setValue(newTaskName, forKey: "taskName")
                 //objectUpdate.setValue("newImportance", forKey: "importance")
                 //objectUpdate.setValue("newAsstimatedWorkTime", forKey: "asstimatedWorkTime")
                 //objectUpdate.setValue("newDueDate", forKey: "dueDate")
                 objectUpdate.setValue(newNotes, forKey: "notes")
   
                 do{
                     try managedContext.save()
                    print("Updated !.")
                 }
                 catch
                 {
                     print(error)
                 }
             }
         catch
         {
             print(error)
         }
    
     }
    
    func deleteTask(taskId : UUID){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id = %@", taskId as CVarArg)
       
       
        do
        {
            let requiredTask = try managedContext.fetch(fetchRequest)
            
            let taskToFreeSpace = requiredTask[0] as! Task
            
              coreManagment.createFreeSpace(startTime: taskToFreeSpace.startTime!, endTime: taskToFreeSpace.endTime!, date: taskToFreeSpace.date, duration: taskToFreeSpace.asstimatedWorkTime, fullyOccupiedDay: false)
            
            let objectToDelete = requiredTask[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
 
            do{
                try managedContext.save()
 
                print("Deleted !.")
               
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
        
       
        coreManagment.mergeFreeSpaces()
        
        
        
    }
    
 
    
    /*
    func AddTask(mangedObjectContext : NSMangedObjectContext,taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String)
    {
        print(dueDate , " I am in Model task")
        let newTask = Task(context: mangedObjectContext)
                                 newTask.taskName = taskName
                                 newTask.importance = importance
                                 newTask.asstimatedWorkTime = asstimatedWorkTime
                                 newTask.dueDate = dueDate
                                 newTask.notes=notes
                                 newTask.id = UUID()
                               
        print(newTask)
                                 do {
                                  try mangedObjectContext.save()
                                  print("Task saved.")
                                 } catch {
                                  print(error.localizedDescription," Catched in Task model")
                                  }
        
        
    }
    */
    
    
    
    
}

extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element]  {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}

