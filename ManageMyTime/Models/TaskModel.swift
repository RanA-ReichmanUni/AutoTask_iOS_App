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
    
    let lowOpacity:CGFloat=0.2
    let standardOpacity:CGFloat=1
    
    func getTaskColor (task:Task) -> Color
    {
        if(task.color!.hasPrefix("#"))
        {
            return Color(hex:task.color!)
        }
        
        switch task.color!.lowercased() {
        case "red":
            return Color(.systemRed)
        case "teal":
            return Color(.systemTeal)
        case "green":
            return Color(.systemGreen)
        case "orange":
            return Color(.systemOrange)
        case "pink":
            return Color(.systemPink)
        case "blue":
            return Color.blue
        case "indigo":
            return Color(.systemIndigo)
        default:
            return Color(.systemTeal)
        }
        
        
    }
    
    func getTaskColor (color:String) -> Color
       {
           
        if(color.hasPrefix("#"))
         {
             return Color(hex:color)
         }
             
        
        switch color.lowercased() {
           case "red":
               return Color(.systemRed)
           case "teal":
               return Color(.systemTeal)
           case "green":
               return Color(.systemGreen)
           case "orange":
               return Color(.systemOrange)
           case "pink":
               return Color(.systemPink)
           case "blue":
            return Color.blue
           case "indigo":
               return Color(.systemIndigo)
           default:
               return Color(.systemTeal)
           }
           
           
       }
    func completedToggle(taskId:UUID)
    {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                         
             //We need to create a context from this container
             let managedContext = appDelegate.persistentContainer.viewContext
             
             //Prepare the request of type NSFetchRequest  for the entity
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
             fetchRequest.predicate = NSPredicate(format: "id = %@", taskId as CVarArg)
        
            var retrivedTask=Task()
        
             do {
                 
                 let result = try managedContext.fetch(fetchRequest)
                 
                retrivedTask = result[0] as! Task
          
                
             } catch {
                 
                 print("Failed retriving task at setCompleted in Model")
             }
        
            if(retrivedTask.completed)
            {
                retrivedTask.completed=false
            }else{
                retrivedTask.completed=true
            }
        
            do {
                      try managedContext.save()
                          print("Try save OP at model.")
                  } catch let error as NSError {
                      print("Could not save. \(error), \(error.userInfo)")
                }
   
    }
    func getFirstTaskColor() ->Color
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Color.white }
                  
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              
              //Prepare the request of type NSFetchRequest  for the entity
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")

              do {
                  
                  let result = try managedContext.fetch(fetchRequest)
                  
                if (!result.isEmpty)
                {
                    return getTaskColor(color: (result[0] as! Task).color!)
                }
            
                 
              } catch {
                  
                  print("Failed retriving first color")
              }
        
        return Color.white
    }
    
    func getSettingsValues () -> SettingsEntity
    {
        
    
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return SettingsEntity() }
        

        let managedContext = appDelegate.persistentContainer.viewContext
        

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SettingsEntity")
 //
         
     
        do {
            
             let result = try managedContext.fetch(fetchRequest)
         
            
            
             if(!result.isEmpty)
             {
                 return result[0] as! SettingsEntity

             }
             else{
                 var settingsObject=SettingsEntity(context: managedContext)
                
                    settingsObject = SettingsEntity(context: managedContext)
                                
                    settingsObject.scheduleAlgorithim=scheduleAlgorithm.smart.rawValue
                    settingsObject.scheduleDensity=scheduleDensity.mediumDensity.rawValue
                    settingsObject.breakPeriods=breakPeriods.hourAndAHalf.rawValue
                
                    do{
                          try managedContext.save()
                         print("Updated !.")
                      }
                      catch
                      {
                          print(error)
                      }
                   
                   return settingsObject
            }
            
        } catch {
            
            print("Failed")
        }

        return SettingsEntity()
     
        
    }
    
    func intialValuesSetup()
    {
            
           //As we know that container is set up in the AppDelegates so we need to refer that container.
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
           
           //Prepare the request of type NSFetchRequest  for the entity
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SettingsEntity")
            //fetchRequest.predicate = NSPredicate(format: "isTaskBreakWindow = %@",argumentArray: [false])
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
             
        
           do {
               
                let result = try managedContext.fetch(fetchRequest)
            
                if(result.isEmpty)
                {
                    
                        var settingsObject=SettingsEntity(context: managedContext)
                           settingsObject.scheduleAlgorithim=scheduleAlgorithm.smart.rawValue
                           settingsObject.scheduleDensity=scheduleDensity.mediumDensity.rawValue
                           settingsObject.breakPeriods=breakPeriods.hourAndAHalf.rawValue
                        do{
                               try managedContext.save()
                              print("Updated !.")
                           }
                           catch
                           {
                               print(error)
                           }
                    
      
            }
               
           } catch {
               
               print("Failed")
           }
   
         
        
    }
    
    func SetSettingsValues(scheduleAlgorithim:String,scheduleDensity:String,breakPeriodsValue:String)
     {
         
          //As we know that container is set up in the AppDelegates so we need to refer that container.
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
          
          //We need to create a context from this container
          let managedContext = appDelegate.persistentContainer.viewContext
          
          //Prepare the request of type NSFetchRequest  for the entity
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SettingsEntity")

            
       
          do {
              
               let result = try managedContext.fetch(fetchRequest)
           
               if(!result.isEmpty)
               {
                
                  
                   var retrivedObject = result[0] as! NSManagedObject
                   
                      retrivedObject.setValue(scheduleAlgorithim, forKey: "scheduleAlgorithim")
                      retrivedObject.setValue(scheduleDensity, forKey: "scheduleDensity")
                        retrivedObject.setValue(breakPeriodsValue, forKey: "breakPeriods")
                
        
               }
               else{
                  
                  var settingsObject=SettingsEntity(context: managedContext)
                  
                      settingsObject.scheduleAlgorithim=scheduleAlgorithim
                      settingsObject.scheduleDensity=scheduleDensity
                      settingsObject.breakPeriods=breakPeriods.hourAndAHalf.rawValue
              }
              
          } catch {
              
              print("Failed")
          }
  
           do{
                try managedContext.save()
               print("Updated !.")
            }
            catch
            {
                print(error)
            }

      
      
      
      
         
     }
    
    func setSettingsValues(scheduleAlgorithim:String,scheduleDensity:String)
       {
           
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SettingsEntity")

              
         
            do {
                
                 let result = try managedContext.fetch(fetchRequest)
             
                 if(!result.isEmpty)
                 {
                  
                    
                     var retrivedObject = result[0] as! NSManagedObject
                     
                        retrivedObject.setValue(scheduleAlgorithim, forKey: "scheduleAlgorithim")
                        retrivedObject.setValue(scheduleDensity, forKey: "scheduleDensity")
          
                 }
                 else{
                    
                    var settingsObject=SettingsEntity(context: managedContext)
                    
                        settingsObject.scheduleAlgorithim=scheduleAlgorithim
                        settingsObject.scheduleDensity=scheduleDensity
                        settingsObject.breakPeriods=breakPeriods.hourAndAHalf.rawValue
                }
                
            } catch {
                
                print("Failed")
            }
    
             do{
                  try managedContext.save()
                 print("Updated !.")
              }
              catch
              {
                  print(error)
              }

        
        
        
        
           
       }
    
    
    func autoFillTesting() throws
    {

        
        let taskName = ["Algebra Ex.1","Infi Ex.2","Marketing Ex.4","Reading In Modern Physics"/*,"Hello","Task Kinger","Algebra","Infi","Some nice Task!","Task King"*//*,"Hello","Task Kinger","Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger","Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger","Algebra","Infi","Some nice Task!","Task King","Hello","Task Kinger"*/]
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext


        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 10
        dateComponents.day = 3
        dateComponents.hour=22
        dateComponents.minute=0

        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let someDateTime = userCalendar.date(from: dateComponents)
        
        let colorArray = ["Green","Teal","Pink","Red","Orange","Blue","Indigo"].shuffled()
       
        let difficultyValues = ["diffcult","average","easy"].shuffled()
        
        let startTime=Hour(context: managedContext)
            startTime.hour=7
            startTime.minutes=0
        let endTime=Hour(context: managedContext)
            endTime.hour=15
            endTime.minutes=0
        
        createRestrictedSpace(name:"TextFill",color:Color.green.description,startTime: startTime,endTime: endTime,dayOfTheWeek: "Wednesday",difficulty:"average")
         createRestrictedSpace(name:"Basketball",color:Color.green.description,startTime: startTime,endTime: endTime,dayOfTheWeek: "Thursday",difficulty:"average")
        createRestrictedSpace(name:"Studies At Unvirsity",color:Color.green.description,startTime: startTime,endTime: endTime,dayOfTheWeek: "Friday",difficulty:"average")
        
        
        let startTime2=Hour(context: managedContext)
            startTime2.hour=12
            startTime2.minutes=0
        let endTime2=Hour(context: managedContext)
            endTime2.hour=15
            endTime2.minutes=0
        
        //createRestrictedSpace(startTime: startTime2,endTime: endTime2,dayOfTheWeek: "Friday")
        
        
       let startTime3=Hour(context: managedContext)
                startTime3.hour=8
                startTime3.minutes=0
            let endTime3=Hour(context: managedContext)
                endTime3.hour=11
                endTime3.minutes=0
            
          //  createRestrictedSpace(startTime: startTime3,endTime: endTime3,dayOfTheWeek: "Friday")
        
        
        let startTime4=Hour(context: managedContext)
                   startTime4.hour=11
                   startTime4.minutes=0
               let endTime4=Hour(context: managedContext)
                   endTime4.hour=17
                   endTime4.minutes=0
               
              createRestrictedSpace(name:"TextFill2",color:Color.green.description,startTime: startTime4,endTime: endTime4,dayOfTheWeek: "Saturday",difficulty:"average")
          createRestrictedSpace(name:"Studies",color:Color.green.description,startTime: startTime4,endTime: endTime4,dayOfTheWeek: "Wednesday",difficulty:"average")
          createRestrictedSpace(name:"Studies",color:Color.green.description,startTime: startTime4,endTime: endTime4,dayOfTheWeek: "Sunday",difficulty:"average")
        for name in taskName
        {
            //Critical error in the notation example code, this is the same hour each time in the context that is being saved repeaditly ! , meaning that asstimatedWorkTime changes to the last tasks asstimatedWorkTime random value, create a new Object to fix it !
            
            
           /* asstimatedWorkTime.hour=Int.random(in: 3 ... 5)
            asstimatedWorkTime.minutes=Int.random(in: 0 ... 59)*/
            
            
            let asstimatedWorkTime=Hour(context: managedContext)
                    asstimatedWorkTime.hour=Int.random(in: 1 ... 3)
                    asstimatedWorkTime.minutes=Int.random(in: 0 ... 59)
           do {
            try coreManagment.ScheduleTask(taskName: name, importance: "Very High", asstimatedWorkTime: asstimatedWorkTime, dueDate: someDateTime!, notes: "Hi",difficulty:"average",color:colorArray[Int.random(in: 0 ... 6)])
           }
            catch{
                 throw DatabaseError.taskCanNotBeScheduledInDue
            }
            
            
            do {
                      try managedContext.save()
                          print("Try save OP at model.")
                  } catch let error as NSError {
                      print("Could not save. \(error), \(error.userInfo)")
                  }
        }
        

        
    }
    func createData(taskName:String,importance:String,asstimatedWorkTime:Hour,dueDate:Date,notes:String,color:Color=Color.green,difficulty:String="difficult") throws {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        do {
            try coreManagment.ScheduleTask(taskName: taskName, importance: importance, asstimatedWorkTime: asstimatedWorkTime, dueDate: dueDate, notes: notes,difficulty:difficulty,color:color.description)
        }
        catch{
            throw DatabaseError.taskCanNotBeScheduledInDue
        }
            
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
    
    func createRestrictedSpace(name:String,color:String,startTime: Hour,endTime: Hour,dayOfTheWeek: String,difficulty:String)
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
       
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestrictedSpace")
        fetchRequest.predicate = NSPredicate(format: "dayOfTheWeek = %@", dayOfTheWeek as CVarArg)
        var alreadyScheduled=false
        var allSpacesAtDay = [RestrictedSpace]()
        
            do
            {
   
                let result = try managedContext.fetch(fetchRequest)
                for data in result as! [RestrictedSpace] {
                            
                    allSpacesAtDay.append(data)
                        
                }
            }
            catch
            {
                print(error)
            }
        
        for space in allSpacesAtDay
        {
            
            if(startTime >= space.startTime && endTime <= space.endTime || startTime < space.startTime && endTime > space.startTime || startTime < space.endTime && endTime >= space.endTime )
            {
                alreadyScheduled=true
            }
            
            
        }
        
        if(!alreadyScheduled)
        {
            let restrictedSpace = RestrictedSpace(context: managedContext)
            
            restrictedSpace.startTime=startTime
            restrictedSpace.endTime=endTime
            restrictedSpace.dayOfTheWeek=dayOfTheWeek
            restrictedSpace.id=UUID()
            restrictedSpace.difficulty=difficulty
            restrictedSpace.name=name
            restrictedSpace.color=color
          //  coreManagment.createDayFreeSpace(restrictedStartTime: startTime, restrictedEndTime: endTime, dayOfTheWeek: dayOfTheWeek)

            do {
                     try managedContext.save()
                         print("Saved RestrictedSpace.")
                 } catch let error as NSError {
                     print("Could not save. \(error), \(error.userInfo)")
                 }
        }
        
    }
    
    
    func retrieveTask(taskID : UUID) -> Task {
        print(taskID.uuidString)
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
                       
                  //  print("Name:",retrievedObject.taskName as! String)
                    
                    print(retrievedObject.taskName)
                    print(retrievedObject.id)
                    
                      return retrievedObject
                  }
                    
                  catch
                  {
                      print(error)
                  }
        
            //Shouldn't get here theoretically
            return emptyTask
        }
    
    func retrieveTasksByDate(date:CustomDate) -> [Task] {
          var allTasks=[Task]()
          //As we know that container is set up in the AppDelegates so we need to refer that container.
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasks }
          
          //We need to create a context from this container
          let managedContext = appDelegate.persistentContainer.viewContext
          
          //Prepare the request of type NSFetchRequest  for the entity
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "date.year = %@ AND date.month = %@ AND date.day = %@ AND isTaskBreakWindow = %@",argumentArray: [date.year,date.month,date.day,false])
  //        fetchRequest.fetchLimit = 1
  //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
  //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
  //
          do {
              
              let result = try managedContext.fetch(fetchRequest)
              for data in result as! [Task] {

                      allTasks.append(data)
 
              }
              print("Retrived all tasks !")
              
          } catch {
              
              print("Failed")
          }
      
      return allTasks
    }
    
    func checkEmptyFreeSpaceByDate(date:CustomDate) -> Bool
    {

            
           //As we know that container is set up in the AppDelegates so we need to refer that container.
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
           
           //Prepare the request of type NSFetchRequest  for the entity
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FreeTaskSpace")
        fetchRequest.predicate = NSPredicate(format: "date.year = %@ AND date.month = %@ AND date.day = %@",argumentArray: [date.year,date.month,date.day])
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
           do {
               
               let result = try managedContext.fetch(fetchRequest)
                
                
                if(result.isEmpty)
                {
                    return true
                }
                else{
                    return false
                }
            
           } catch {
               
               print("Failed")
           }
       
     
         return false
        
        
    }
    
    func retrieveFreeSpace(freeSpaceID : UUID) -> FreeTaskSpace {
           
        
             let emptyFreeSpace = FreeTaskSpace()
   
             //As we know that container is set up in the AppDelegates so we need to refer that container.
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return emptyFreeSpace }
             
             //We need to create a context from this container
             let managedContext = appDelegate.persistentContainer.viewContext
             
             let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
            fetchRequest.predicate = NSPredicate(format: "id = %@", freeSpaceID as CVarArg)
             do
             {
                 let requiredFreeSpace = try managedContext.fetch(fetchRequest)
                   
                     let retrievedObject = requiredFreeSpace[0] as! FreeTaskSpace
                  
             //  print("Name:",retrievedObject.taskName as! String)
               

               
                 return retrievedObject
             }
               
             catch
             {
                 print(error)
             }
   
       //Shouldn't get here theoretically
       return emptyFreeSpace
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
             fetchRequest.predicate = NSPredicate(format: "isTaskBreakWindow = %@",argumentArray: [false])
    //        fetchRequest.fetchLimit = 1
    //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
    //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
    //
            do {
                
                let result = try managedContext.fetch(fetchRequest)
                for data in result as! [Task] {
                        
                    /*if(data.taskName=="Task King")
                    {
                            print("Task Status: ")
                            print(data.taskName)
                            print("Duration ",data.asstimatedWorkTime.hour,":",data.asstimatedWorkTime.minutes)
                            print("Start Time ",data.startTime!.hour,":",data.startTime!.minutes)
                            print("End Time ",data.endTime!.hour,":",data.endTime!.minutes)
                    }*/
                    
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
              var opacity:CGFloat
          
              //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasks }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              
              //Prepare the request of type NSFetchRequest  for the entity
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
         
        fetchRequest.predicate = NSPredicate(format: "date.year = %@ AND date.month = %@ AND date.day = %@ AND isTaskBreakWindow = %@", argumentArray: [Date().year,Date().month,Date().day,false])
                  
              let nextHour = Hour(context: managedContext)
                  nextHour.hour=hour+1
                  nextHour.minutes=0
              
              let beginningOfHour = Hour(context: managedContext)
              beginningOfHour.hour=hour
              beginningOfHour.minutes=0
        
            let currentTime=Hour(context: managedContext)
            currentTime.hour=Date().hour
            currentTime.minutes=Date().minutes
              
        
            let currentDate = CustomDate(context:managedContext)
                 currentDate.year=Date().year
                 currentDate.month=Date().month
                 currentDate.day=Date().day
             
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
                                        
                                        if(task.completed || task.date < currentDate || task.date == currentDate && nextHour < currentTime)
                                        {
                                            opacity=lowOpacity
                                        }else
                                        {
                                            opacity=standardOpacity
                                        }
                                        var taskPerHour=TaskPerHour(heightFactor: heightFactor , taskName: task.taskName,color:getTaskColor(task: task),opacity:opacity)
                                        
                                        taskPerHour.id=task.id
                                        
                                        tasksPerHourPerDay.tasks.append(taskPerHour)
                    
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
                                        if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)
                                           {
                                               opacity=lowOpacity
                                           }else
                                           {
                                               opacity=standardOpacity
                                           }
                                        
                                        var taskPerHour=TaskPerHour(heightFactor: CGFloat(1.5) , taskName: data[0].taskName,color:getTaskColor(task: data[0]),opacity:opacity)
                                                                           
                                        taskPerHour.id=data[0].id
                                        
                                        tasksPerHourPerDay.tasks.append(taskPerHour)
                                              //Multiple tasks per hour
                                    }
                                    else if(data[0].endTime! < nextHour && data[0].endTime!.minutes < 30)
                                    {
                                        if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)//SET LOW OPACITY to past tasks
                                           {
                                               opacity=lowOpacity
                                           }else
                                           {
                                               opacity=standardOpacity
                                           }
                                        var taskPerHour=TaskPerHour(heightFactor: CGFloat(1) , taskName: data[0].taskName,color:getTaskColor(task: data[0]),opacity:opacity)
                                                                                                            
                                        taskPerHour.id=data[0].id
                                        
                                        tasksPerHourPerDay.tasks.append(taskPerHour)
                                                                                 //Multiple tasks per hour
                                    }
                                    else{
                                        if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)//SET LOW OPACITY to past tasks
                                            {
                                                opacity=lowOpacity
                                            }else
                                            {
                                                opacity=standardOpacity
                                            }
                                        var taskPerHour=TaskPerHour(heightFactor: heightFactor , taskName: data[0].taskName,color:getTaskColor(task: data[0]),opacity:opacity)
                                                                                                                                            
                                        taskPerHour.id=data[0].id
                                        
                                         tasksPerHourPerDay.tasks.append(taskPerHour)
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
                     
                      
                      print("Retrived all day tasks !")
                      
                    }       catch {
                      
                      print("Failed")
                  }
              
              return allTasks
    }
    
    
    func retrieveAllTasksByHour(hour:Int,sequanceNum:Int) -> [TasksPerHourPerDay] {
              
           var allTasks=[TasksPerHourPerDay]()
           var coreManagment=Core()
       
           var opacity:CGFloat
        
           let startOfDay=7
           let endOfDay=24
       
           //As we know that container is set up in the AppDelegates so we need to refer that container.
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasks }
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
           
           //Prepare the request of type NSFetchRequest  for the entity
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
      
           fetchRequest.predicate = NSPredicate(format: "date.year >= %@ ", argumentArray: [Date().year])
               
           let nextHour = Hour(context: managedContext)
               nextHour.hour=hour+1
               nextHour.minutes=0
           
           let beginningOfHour = Hour(context: managedContext)
           beginningOfHour.hour=hour
           beginningOfHour.minutes=0
           
            let currentTime=Hour(context: managedContext)
                     currentTime.hour=Date().hour
                     currentTime.minutes=Date().minutes
                   
         
             let currentDate = CustomDate(context:managedContext)
                  currentDate.year=Date().year
                  currentDate.month=Date().month
                  currentDate.day=Date().day
                    
               let weekSequence=coreManagment.createCalanderSequence(startDay: 27, startMonth: 9, startYear: 2020, endDay: 3, endMonth: 10, endYear: 2020)
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
                    
                        var dayOfTheWeek=weekSequence[sequanceNum]
                        
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
                                    if(task.completed || task.date < currentDate || task.date == currentDate && nextHour < currentTime)
                                           {
                                               opacity=lowOpacity
                                           }else
                                           {
                                               opacity=standardOpacity
                                           }
                                        var taskPerHour=TaskPerHour(heightFactor: heightFactor , taskName: task.taskName,color:getTaskColor(task: task),opacity:opacity)
                                                                                                                                                                           
                                        taskPerHour.id=task.id
                                    
                                       tasksPerHourPerDay.tasks.append(taskPerHour)
                 
                                   }
                                                        
                               }
                               /*else{
                                   heightFactor=1.6
                               }*/
                               else{
                                   
                                   if(data[0].startTime! > beginningOfHour)
                                    {
                                        if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)
                                          {
                                              opacity=lowOpacity
                                          }else
                                          {
                                              opacity=standardOpacity
                                          }
                                        tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white),opacity:opacity))
                                    }
                                
                                    if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)
                                      {
                                          opacity=lowOpacity
                                      }else
                                      {
                                          opacity=standardOpacity
                                      }
                                   
                                    var taskPerHour=TaskPerHour(heightFactor: heightFactor , taskName: data[0].taskName,color:getTaskColor(task: data[0]),opacity:opacity)
                                    taskPerHour.id=data[0].id
                                
                                   tasksPerHourPerDay.tasks.append(taskPerHour)
                                           //Multiple tasks per hour
                                   
                                   if(data[0].endTime! < nextHour)
                                    {
                                        if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate &&  nextHour < currentTime)
                                         {
                                             opacity=lowOpacity
                                         }else
                                         {
                                             opacity=standardOpacity
                                         }
                                        
                                         tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white),opacity:opacity))
                                    }
                                   
                                   
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
                  
                   
                   print("Retrived all tasks by hour !")
                   
               } catch {
                   
                   print("Failed")
               }
           
           return allTasks
           }
    
    func retrieveAllTasksByHour(hour:Int) -> [TasksPerHourPerDay] {
                 
              var allTasks=[TasksPerHourPerDay]()
              var coreManagment=Core()
          
              var opacity:CGFloat
           
              let startOfDay=7
              let endOfDay=24
          
              //As we know that container is set up in the AppDelegates so we need to refer that container.
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              
              //Prepare the request of type NSFetchRequest  for the entity
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
         
              fetchRequest.predicate = NSPredicate(format: "date.year >= %@ AND isTaskBreakWindow = %@", argumentArray: [Date().year,false])
                  
              let nextHour = Hour(context: managedContext)
                  nextHour.hour=hour+1
                  nextHour.minutes=0
              
              let beginningOfHour = Hour(context: managedContext)
              beginningOfHour.hour=hour
              beginningOfHour.minutes=0
              
               let currentTime=Hour(context: managedContext)
                        currentTime.hour=Date().hour
                        currentTime.minutes=Date().minutes
                      
            
                let currentDate = CustomDate(context:managedContext)
                     currentDate.year=Date().year
                     currentDate.month=Date().month
                     currentDate.day=Date().day
                       
                  let weekSequence=coreManagment.createCalanderSequence(startDay: 27, startMonth: 9, startYear: 2020, endDay: 3, endMonth: 10, endYear: 2020)
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
                                       if(task.completed || task.date < currentDate || task.date == currentDate && nextHour < currentTime)
                                              {
                                                  opacity=lowOpacity
                                              }else
                                              {
                                                  opacity=standardOpacity
                                              }
                                           var taskPerHour=TaskPerHour(heightFactor: heightFactor , taskName: task.taskName,color:getTaskColor(task: task),opacity:opacity)
                                                                                                                                                                              
                                           taskPerHour.id=task.id
                                       
                                          tasksPerHourPerDay.tasks.append(taskPerHour)
                    
                                      }
                                                           
                                  }
                                  /*else{
                                      heightFactor=1.6
                                  }*/
                                  else{
                                      
                                      if(data[0].startTime! > beginningOfHour)
                                       {
                                           if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)
                                             {
                                                 opacity=lowOpacity
                                             }else
                                             {
                                                 opacity=standardOpacity
                                             }
                                           tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white),opacity:opacity))
                                       }
                                   
                                       if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)
                                         {
                                             opacity=lowOpacity
                                         }else
                                         {
                                             opacity=standardOpacity
                                         }
                                      
                                       var taskPerHour=TaskPerHour(heightFactor: heightFactor , taskName: data[0].taskName,color:getTaskColor(task: data[0]),opacity:opacity)
                                       taskPerHour.id=data[0].id
                                   
                                      tasksPerHourPerDay.tasks.append(taskPerHour)
                                              //Multiple tasks per hour
                                      
                                      if(data[0].endTime! < nextHour)
                                       {
                                           if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate &&  nextHour < currentTime)
                                            {
                                                opacity=lowOpacity
                                            }else
                                            {
                                                opacity=standardOpacity
                                            }
                                           
                                            tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white),opacity:opacity))
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
                     
                      
                      print("Retrived all tasks by hour !")
                      
                  } catch {
                      
                      print("Failed")
                  }
              
              return allTasks
              }
    
    func retrieveAllTasksByHour() -> [TasksPerHourPerDayOfTheWeek] {
                
             var allTasksPerDay=[TasksPerHourPerDay]()
             var allTasksObject=[TasksPerHourPerDayOfTheWeek]()
             var coreManagment=Core()
         
             var opacity:CGFloat
          
             let startOfDay=7
             let endOfDay=24
         
             //As we know that container is set up in the AppDelegates so we need to refer that container.
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return allTasksObject }
             
             //We need to create a context from this container
             let managedContext = appDelegate.persistentContainer.viewContext
             
             //Prepare the request of type NSFetchRequest  for the entity
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
             fetchRequest.predicate = NSPredicate(format: "date.year >= %@ AND  isTaskBreakWindow = %@", argumentArray: [Date().year,false])
                 
             let nextHour = Hour(context: managedContext)
              
             
             let beginningOfHour = Hour(context: managedContext)
     
             
              let currentTime=Hour(context: managedContext)
                       currentTime.hour=Date().hour
                       currentTime.minutes=Date().minutes
                     
           
               let currentDate = CustomDate(context:managedContext)
                    currentDate.year=Date().year
                    currentDate.month=Date().month
                    currentDate.day=Date().day
                      
                 let weekSequence=coreManagment.createCalanderSequence(startDay: 27, startMonth: 9, startYear: 2020, endDay: 3, endMonth: 10, endYear: 2020)
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
                    
                        for hour in startOfDay...endOfDay
                        {
                                nextHour.hour=hour+1
                                nextHour.minutes=0
                                beginningOfHour.hour=hour
                                beginningOfHour.minutes=0
                            
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
                                          if(task.completed || task.date < currentDate || task.date == currentDate && nextHour < currentTime)
                                                 {
                                                     opacity=lowOpacity
                                                 }else
                                                 {
                                                     opacity=standardOpacity
                                                 }
                                              var taskPerHour=TaskPerHour(heightFactor: heightFactor , taskName: task.taskName,color:getTaskColor(task: task),opacity:opacity)
                                                                                                                                                                                 
                                              taskPerHour.id=task.id
                                          
                                             tasksPerHourPerDay.tasks.append(taskPerHour)
                       
                                         }
                                                              
                                     }
                                     /*else{
                                         heightFactor=1.6
                                     }*/
                                     else{
                                         
                                         if(data[0].startTime! > beginningOfHour)
                                          {
                                              if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)
                                                {
                                                    opacity=lowOpacity
                                                }else
                                                {
                                                    opacity=standardOpacity
                                                }
                                              tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white),opacity:opacity))
                                          }
                                      
                                          if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate && nextHour < currentTime)
                                            {
                                                opacity=lowOpacity
                                            }else
                                            {
                                                opacity=standardOpacity
                                            }
                                         
                                          var taskPerHour=TaskPerHour(heightFactor: heightFactor , taskName: data[0].taskName,color:getTaskColor(task: data[0]),opacity:opacity)
                                          taskPerHour.id=data[0].id
                                      
                                         tasksPerHourPerDay.tasks.append(taskPerHour)
                                                 //Multiple tasks per hour
                                         
                                         if(data[0].endTime! < nextHour)
                                          {
                                              if(data[0].completed || data[0].date < currentDate || data[0].date == currentDate &&  nextHour < currentTime)
                                               {
                                                   opacity=lowOpacity
                                               }else
                                               {
                                                   opacity=standardOpacity
                                               }
                                              
                                               tasksPerHourPerDay.tasks.append(TaskPerHour(heightFactor: heightFactor , taskName: "",color:Color(.white),opacity:opacity))
                                          }
                                         
                                         
                                     }
                              
                   
                                   
                                 }
                                 else{//Case it's an empty hour for that day (index)
                                     tasksPerHourPerDay=TasksPerHourPerDay(isEmptySlot: true, tasks: [TaskPerHour]())
                                     //tasksPerHourPerDay.isEmptySlot=true
                                 }
                                 
                                 allTasksPerDay.append(tasksPerHourPerDay)//Tasks per hour
                                
                                 tasksPerHourPerDay.tasks=[]
                            }
                            allTasksObject.append(TasksPerHourPerDayOfTheWeek(hour: hour, tasks: allTasksPerDay))
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
                    
                     
                     print("Retrived all tasks by hour !")
                     
                 } catch {
                     
                     print("Failed")
                 }
             
             return allTasksObject
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
    
    
    func UpdateData(id : UUID,newTaskName : String, newNotes : String,color:String ){
      
          //As we know that container is set up in the AppDelegates so we need to refer that container.
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
          
          //We need to create a context from this container
          let managedContext = appDelegate.persistentContainer.viewContext
          
          let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
          fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
          do
          {
              let requiredTask = try managedContext.fetch(fetchRequest)
     
                  let objectUpdate = requiredTask[0] as! NSManagedObject
                  objectUpdate.setValue(newTaskName, forKey: "taskName")
                 // objectUpdate.setValue("newImportance", forKey: "importance")
                  //objectUpdate.setValue(newAsstimatedWorkTime, forKey: "asstimatedWorkTime")
                  //objectUpdate.setValue(newDueDate, forKey: "dueDate")
                  objectUpdate.setValue(newNotes, forKey: "notes")
                  objectUpdate.setValue(color, forKey: "color")

                
    
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
       
        var freeSpaceId=UUID()
        
        do
        {
            let requiredTask = try managedContext.fetch(fetchRequest)
            
            let taskToFreeSpace = requiredTask[0] as! Task
              
            
            DeleteAllByInternalId(internalId: taskToFreeSpace.internalId!)
            
        }
        catch
        {
            print(error)
        }
        
       
       // coreManagment.mergeFreeSpaces(createdFreeSpace:freeSpaceId)
        
        
        
    }
    
 func DeleteAllByInternalId(internalId:UUID)
    {
           //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
              fetchRequest.predicate = NSPredicate(format: "internalId = %@", internalId as CVarArg)
             
            var freeSpaceId:UUID
        
              var tasks=[Task]()
        
              do
              {
                  let results = try managedContext.fetch(fetchRequest)
                
                  for result in results as! [NSManagedObject] {

                        let spaceObj = result as! Task
                    
                        tasks.append(spaceObj)
                        
                   }
                    
                for task in tasks
                {

                    freeSpaceId=coreManagment.createFreeSpace(startTime: task.startTime!, endTime: task.endTime!, date: task.date, duration: task.asstimatedWorkTime, fullyOccupiedDay: false,orginalFreeSpaceAssociatedId:task.associatedFreeSpaceId!)
                    
                    print("FreeSpace is from"+String(task.startTime!.hour)+":"+String(task.startTime!.minutes)+" To "+String(task.endTime!.hour)+":"+String(task.endTime!.minutes))
                    
                    let objectToDelete = task as! NSManagedObject
                    managedContext.delete(objectToDelete)
                    do{
                        try managedContext.save()
         
                        print("Deleted !.")
                       
                    }
                    catch
                    {
                        print(error)
                    }
                    print("Going to merge "+freeSpaceId.description)
                   
                    print("FreeSpace from ")
                    let freeSpaceObj=retrieveFreeSpace(freeSpaceID: freeSpaceId)
                     print("Free space from "+String(freeSpaceObj.starting.hour)+":"+String(freeSpaceObj.starting.minutes)+" To "+String(freeSpaceObj.ending.hour)+":"+String(freeSpaceObj.ending.minutes))
                    
                    coreManagment.mergeFreeSpaces(createdFreeSpace:freeSpaceId)
                    print("after merge freeSpaces")
                }
                
                
            
       
            
                  
              }
              catch
              {
                  print(error)
              }
              
             
              
        
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

