//
//  TimeManagementCore.swift
//  ManageMyTime
//
//  Created by רן א on 04/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Core{
    
    let startOfTheDay = 7
    let endOfTheDay = 22
    
    enum coreError: Error {
           case dayOfCurrentDayIsZero
           case badPassword
       }
    
    
    
    
    
  /*  func ScheduleTask(taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String)
    {
        
        let todayDay = Date().day
        var retrivedFreeDays = [AvailableDay]()
        var day : Int
        var spaceObj : FreeSpace
        
        
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Now let’s create an entity and new user records.
            let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
            
            //final, we need to add some data to our newly created record for each keys using
            //here adding 5 data with loop
            

                
            
                let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
                task.setValue(taskName, forKeyPath: "taskName")
                task.setValue(importance, forKeyPath: "importance")
                task.setValue(asstimatedWorkTime, forKeyPath: "asstimatedWorkTime")
                task.setValue(dueDate, forKeyPath: "dueDate")
                task.setValue(notes, forKeyPath: "notes")
                let id = UUID()
                task.setValue(id, forKeyPath: "id")

            //Now we have set all the values. The next step is to save them inside the Core Data
            
            do {
                try managedContext.save()
                    print("Saved !.")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            
            
        
                        
        
           //Now let’s create an entity and new user records.
                    let freeTimeSpaceEntity = NSEntityDescription.entity(forEntityName: "FreeSpace", in: managedContext)!
                    
                    //final, we need to add some data to our newly created record for each keys using
                    //here adding 5 data with loop
                     let timeByHourEntity = NSEntityDescription.entity(forEntityName: "Hour", in: managedContext)!
                      
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeSpace")
        
        
                    fetchRequest.predicate = NSPredicate(format: "month <= %@ AND day <= %@ AND day >= %@", argumentArray: [dueDate.month,dueDate.day, todayDay])
                                  
                              
                    do
                    {
                        let results = try managedContext.fetch(fetchRequest)
                        
                        if (results.count == 0)
                        {
                            print("It's 0 ")
                            
                        }else{
                            
                            
                          for result in results as! [NSManagedObject] {

                                var day = result.value(forKey: "day") as! Int
                                var spaceObj = result as! FreeSpace
                            
                            retrivedFreeDays.append(AvailableDay(freeSpaceObj : spaceObj ,day : day))
                                
                           }
                            
                            retrivedFreeDays.sort{ $0.day == $1.day ? $0.day < $1.day : $0.month < $1.month }

                            retrivedFreeDays.sort {
                              ($0.day, $0.month) <
                                ($1.day, $1.month)
                            }
                            
                            //retrivedFreeDays=retrivedFreeDays.sorted(by:{$0.day > $1.day})//sorted by the rule of $0 item day field is > then somw other $1 item day field
                            
                            
                        }
                        
                        for dayInRange in todayDay...dueDate.day
                        {
                            if (retrivedFreeDays.contains(where: { $0.day == dayInRange}))
                            {
                                if(
                                
                                
                            }
                            else{
                                
                                
                            }
                            
                            
                        }
                                       
                                                  // let retrievedObject = requiredTask[0] as! Task
                                                 
                                             // print("Name:",retrievedObject.taskName as! String)
                                              
                                               
                         }
                                              
                         catch
                         {
                            print(error)
                         }
                                  
                            
              
                      let task = NSManagedObject(entity: freeTimeSpaceEntity, insertInto: managedContext)
                      task.setValue(7, forKeyPath: "day")
                      task.setValue(7, forKeyPath: "month")
                      task.setValue(2020, forKeyPath: "year")
                      task.setValue(startTime, forKeyPath: "starting")
                      task.setValue(endTime, forKeyPath: "ending")
                      task.setValue(duration, forKeyPath: "duration")
                      task.setValue(UUID(), forKeyPath: "id")

                    //Now we have set all the values. The next step is to save them inside the Core Data
                    
                    do {
                        try managedContext.save()
                            print("Saved !.")
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
              
            
            
            let startTime = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                                 startTime.setValue(10, forKeyPath: "hour")
                                 startTime.setValue(45, forKeyPath: "minutes")
                         
                                        let endTime = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                                         endTime.setValue(11, forKeyPath: "hour")
                                         endTime.setValue(15, forKeyPath: "minutes")
                         
                                 let duration = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                                                       endTime.setValue(1, forKeyPath: "hour")
                                                       endTime.setValue(0, forKeyPath: "minutes")
            
            

            
            
            
            
            
            
            let spaceEntity = NSEntityDescription.entity(forEntityName: "OccupiedTimeSpace", in: managedContext)!
                  
                  //final, we need to add some data to our newly created record for each keys using
                  //here adding 5 data with loop
                  
            let currentMinute=Calendar.current.component(.minute, from: Date())
            
            
            var startTime = 8
            var endTime = 9.5
            
                      let space = NSManagedObject(entity: spaceEntity, insertInto: managedContext)
                      space.setValue(taskName, forKeyPath: "assignedTaskName")
                      space.setValue(id, forKeyPath: "assignedTaskId")
                      space.setValue(false, forKeyPath: "restFreeSpace")
                      space.setValue(startTime, forKeyPath: "startTime")
                      space.setValue(endTime, forKeyPath: "endTime")
                      space.setValue("red", forKeyPath: "color")
                      space.setValue(UUID(), forKeyPath: "id")
                      space.setValue(7, forKeyPath: "day")
                      space.setValue(8, forKeyPath: "month")
                      space.setValue(2020, forKeyPath: "year")

                  //Now we have set all the values. The next step is to save them inside the Core Data
                  
                  do {
                      try managedContext.save()
                          print("Saved space !.")
                  } catch let error as NSError {
                      print("Could not save. \(error), \(error.userInfo)")
                  }
                  
        
        
    }*/
    
  func retrieveAllSpaces() throws//We assume all appropriate days have been constructed beforehand
    {

         var dayOfToday = Date().day
        
        if (dayOfToday==0)
        {
            throw coreError.dayOfCurrentDayIsZero
        }
        
     
                    //As we know that container is set up in the AppDelegates so we need to refer that container.
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                      
                      //We need to create a context from this container
                    let managedContext = appDelegate.persistentContainer.viewContext
                      
             
            
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "OccupiedSpace")
                   /* let predicate1 = NSPredicate(format: "month = %@",8)
                    let predicate2 = NSPredicate(format: "month <%@",15)
                    let predicate3 = NSPredicate(format: "year = %@",2020)
                    let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2,predicate3])*/
        
                    fetchRequest.predicate = NSPredicate(format: "month > %@ AND month < %@", argumentArray: [8, 11])
                    //fetchRequest.sortDescriptors=[NSSortDescriptor(keyPath: \OccupiedSpace.startTime, ascending: true)]
        
                      do
                      {
                          let results = try managedContext.fetch(fetchRequest)
                      
                        if (results.count == 0)
                        {
                            print("It's 0 ")
                        }
                        
                        for result in results as! [NSManagedObject] {
                                print("Name: ")
                                print(result.value(forKey: "assignedTaskName") as! String)
                                print("startTime: ")
                            print(result.value(forKey: "startTime")!)
                        }
                        
                      
                            // let retrievedObject = requiredTask[0] as! Task
                           
                       // print("Name:",retrievedObject.taskName as! String)
                        
                         
                      }
                        
                      catch
                      {
                          print(error)
                      }
            
            
            
            
            
        
        
        
            
    }
    
    
    func retrieveAllFreeSpaces() throws//We assume all appropriate days have been constructed beforehand
       {

            var dayOfToday = Date().day
           
           if (dayOfToday==0)
           {
               throw coreError.dayOfCurrentDayIsZero
           }
           
        
                       //As we know that container is set up in the AppDelegates so we need to refer that container.
                       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                         
                         //We need to create a context from this container
                       let managedContext = appDelegate.persistentContainer.viewContext
                         
                
               
                       let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeSpace")
                      /* let predicate1 = NSPredicate(format: "month = %@",8)
                       let predicate2 = NSPredicate(format: "month <%@",15)
                       let predicate3 = NSPredicate(format: "year = %@",2020)
                       let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2,predicate3])*/
           
                       fetchRequest.predicate = NSPredicate(format: "starting.hour > %@ AND starting.hour < %@", argumentArray: [8, 11])
               
           
                         do
                         {
                             let results = try managedContext.fetch(fetchRequest)
                         
                           if (results.count == 0)
                           {
                               print("It's 0 ")
                           }
                           
                           for result in results as! [NSManagedObject] {
                                print("Id: ")
                                var id = result.value(forKey: "id") as! UUID
                                print(id.uuidString)
                                var startingTime = result.value(forKey: "starting") as! Hour
                                print("startTime.hour: ")
                                print(startingTime.minutes)
                           }
                           
                         
                               // let retrievedObject = requiredTask[0] as! Task
                              
                          // print("Name:",retrievedObject.taskName as! String)
                           
                            
                         }
                           
                         catch
                         {
                             print(error)
                         }
               
               
               
               
               
           
           
           
               
       }
    
     func createFreeSpace(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              
              //Now let’s create an entity and new user records.
              let freeTimeSpaceEntity = NSEntityDescription.entity(forEntityName: "FreeSpace", in: managedContext)!
              
              //final, we need to add some data to our newly created record for each keys using
              //here adding 5 data with loop
               let timeByHourEntity = NSEntityDescription.entity(forEntityName: "Hour", in: managedContext)!
                
                let startTime = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                startTime.setValue(10, forKeyPath: "hour")
                startTime.setValue(45, forKeyPath: "minutes")
        
                       let endTime = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                        endTime.setValue(11, forKeyPath: "hour")
                        endTime.setValue(15, forKeyPath: "minutes")
        
                let duration = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                                      endTime.setValue(1, forKeyPath: "hour")
                                      endTime.setValue(0, forKeyPath: "minutes")
                      
        
                let task = NSManagedObject(entity: freeTimeSpaceEntity, insertInto: managedContext)
                task.setValue(7, forKeyPath: "day")
                task.setValue(7, forKeyPath: "month")
                task.setValue(2020, forKeyPath: "year")
                task.setValue(startTime, forKeyPath: "starting")
                task.setValue(endTime, forKeyPath: "ending")
                task.setValue(duration, forKeyPath: "duration")
                task.setValue(UUID(), forKeyPath: "id")

              //Now we have set all the values. The next step is to save them inside the Core Data
              
              do {
                  try managedContext.save()
                      print("Saved !.")
              } catch let error as NSError {
                  print("Could not save. \(error), \(error.userInfo)")
              }
        
        
    }
    
    
    
    
    func deleteSpace(assignedTaskName : String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OccupiedTimeSpace")
        fetchRequest.predicate = NSPredicate(format: "taskName = %@", assignedTaskName)
       
        do
        {
            let requiredSpace = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = requiredSpace[0] as! NSManagedObject
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
    }
    
    
    
    
    func createData(taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
    
            
            let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
            task.setValue(taskName, forKeyPath: "taskName")
            task.setValue(importance, forKeyPath: "importance")
            task.setValue(asstimatedWorkTime, forKeyPath: "asstimatedWorkTime")
            task.setValue(dueDate, forKeyPath: "dueDate")
            task.setValue(notes, forKeyPath: "notes")
            let id = UUID()
            task.setValue(id, forKeyPath: "id")

        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
                print("Saved !.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
        
    
                    
    
       let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "OccupiedSpace")
                          /* let predicate1 = NSPredicate(format: "month = %@",8)
                           let predicate2 = NSPredicate(format: "month <%@",15)
                           let predicate3 = NSPredicate(format: "year = %@",2020)
                           let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2,predicate3])*/
               
        fetchRequest.predicate = NSPredicate(format: "month >= %@ AND month <= %@ AND ", argumentArray: [Date().month, dueDate.month])
       do
       {
            let results = try managedContext.fetch(fetchRequest)
                             
              
        
        
        
        
            for result in results as! [NSManagedObject] {
                
                for hour in startOfTheDay...endOfTheDay
                {
                    //
                    
                    
                }
               print("Name: ")
               print(result.value(forKey: "assignedTaskName") as! String)
                print("startTime: ")
                   print(result.value(forKey: "startTime")!)
             }
                               
                             
                                   // let retrievedObject = requiredTask[0] as! Task
                                  
                              // print("Name:",retrievedObject.taskName as! String)
                               
                                
        }
                               
        catch
        {
            print(error)
        }
        
        
        
        
        
        

        
        
        
        
        
        
        let spaceEntity = NSEntityDescription.entity(forEntityName: "OccupiedTimeSpace", in: managedContext)!
              
              //final, we need to add some data to our newly created record for each keys using
              //here adding 5 data with loop
              
        let currentMinute=Calendar.current.component(.minute, from: Date())
        
        
        var startTime = 8
        var endTime = 9.5
        
                  let space = NSManagedObject(entity: spaceEntity, insertInto: managedContext)
                  space.setValue(taskName, forKeyPath: "assignedTaskName")
                  space.setValue(id, forKeyPath: "assignedTaskId")
                  space.setValue(false, forKeyPath: "restFreeSpace")
                  space.setValue(startTime, forKeyPath: "startTime")
                  space.setValue(endTime, forKeyPath: "endTime")
                  space.setValue("red", forKeyPath: "color")
                  space.setValue(UUID(), forKeyPath: "id")
                  space.setValue(7, forKeyPath: "day")
                  space.setValue(8, forKeyPath: "month")
                  space.setValue(2020, forKeyPath: "year")

              //Now we have set all the values. The next step is to save them inside the Core Data
              
              do {
                  try managedContext.save()
                      print("Saved space !.")
              } catch let error as NSError {
                  print("Could not save. \(error), \(error.userInfo)")
              }
              
        
        
        
        
    }
   
        
        
        
        
        
}

extension Date {
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        return dateFormatter.string(from: self)
    }
    var day: Int {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd"
         return Int(dateFormatter.string(from: self)) ?? 0
     }
    var year: String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy"
         return dateFormatter.string(from: self)
     }
    
    func dayOfWeek() -> String? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           return dateFormatter.string(from: self).capitalized
          
       }//Get value by : "Date().dayOfWeek()!"
    
}


    
    
    
    

