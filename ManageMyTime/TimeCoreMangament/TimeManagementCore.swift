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
    
    

    
   
  func ScheduleTask(taskName:String,importance:String,asstimatedWorkTime:Hour,dueDate:Date,notes:String) -> Task
    {
        
        let todayDay = Date().day
        var retrivedFreeDays = [FreeSpace]()
        var suitableFreeDays = [FreeSpace]()
        var day : Int
        var spaceObj : FreeSpace
        var calanderSequence:[CustomDate]
        
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Task()}
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
        

                        

                let freeTimeSpaceEntity = NSEntityDescription.entity(forEntityName: "FreeSpace", in: managedContext)!

                let timeByHourEntity = NSEntityDescription.entity(forEntityName: "Hour", in: managedContext)!
                      

                let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeSpace")
        
        
                    fetchRequest.predicate = NSPredicate(format: "year >= %@", argumentArray: [dueDate.year])
                                  
                              
                    do
                    {
                        let results = try managedContext.fetch(fetchRequest)
                        
                        if (results.count == 0)
                        {
                            print("It's 0 ")
                            
                        }else{
                            
                            
                          for result in results as! [NSManagedObject] {

                                var day = result.value(forKey: "day") as! Int
                                let spaceObj = result as! FreeSpace
                            
                                retrivedFreeDays.append(spaceObj)
                                
                           }
                        
                           //retrivedFreeDays.sort{ $0.day == $1.day ? $0.day < $1.day : $0.month < $1.month } not good, it's only two arguments
                            
                            
                            //Sort by this order preference: year, month, day
                            retrivedFreeDays.sort {
                                ($0.date.year, $0.date.month, $0.date.day,$0.starting.hour) <
                                    ($1.date.year,$1.date.month,$1.date.day,$0.starting.hour)
                            }
                         
                            for freeDay in retrivedFreeDays
                            
                            {//Filter and find relevent future freeSpace days in context to dueDate of the new task
                               
                                if (dueDate.year < freeDay.date.year)//If it's a future year then any date relevent
                                {
                                    print("Item:",String(freeDay.date.day)," ",String(freeDay.date.month)," ",String(freeDay.date.year))
                                }
                                else if(dueDate.year == freeDay.date.year && dueDate.month <= freeDay.date.month)//If it's the same year (so it won't be any past year in time) then check if it's a future or same month and not a past month.
                                {
                                                             
                                    if((dueDate.day <= freeDay.date.day && dueDate.month == freeDay.date.month) || (dueDate.month < freeDay.date.month) )//If it's the same month, check for day, if it's a future month then all dates are relevent
                                    {
                                        suitableFreeDays.append(freeDay)
                                        
                                    }
                                                                                              
                                }
                                
                            }
                            //retrivedFreeDays=retrivedFreeDays.sorted(by:{$0.day > $1.day})//sorted by the rule of $0 item day field is > then somw other $1 item day field
                            
                            
                        }
                        
                        
                        let thisMoment = CustomDate(context:managedContext)
                            
                        thisMoment.year=Date().year
                        thisMoment.month=Date().month
                        thisMoment.day=Date().day
                        
                        let endDueDate = CustomDate(context:managedContext)
                        endDueDate.year=dueDate.year
                        endDueDate.month=dueDate.month
                        endDueDate.day=dueDate.day
                        
                        calanderSequence = createCalanderSequence(startDate:thisMoment, endDate: endDueDate)
                        
                        for singleDate in calanderSequence
                        {
                            
                            if(suitableFreeDays.contains(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day) && $0.duration.isBiggerOrEqual(newHour: asstimatedWorkTime)}) )//Check if we have FreeSpace object in that date sequance between this moment and dueDate
                            {
                                let exsitingDay=suitableFreeDays.first(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day) && $0.duration.isBiggerOrEqual(newHour: asstimatedWorkTime)})! //Contains closest FreeSpace slot
                               
                                
                                
                                //Create task
                                
                                let newTask = Task(context: managedContext)
                                newTask.taskName=taskName
                                newTask.dueDate=dueDate
                                newTask.date!.day=exsitingDay.date.day
                                newTask.date!.month=exsitingDay.date.month
                                newTask.date!.year=exsitingDay.date.year
                                newTask.startTime=exsitingDay.starting
                                newTask.endTime=exsitingDay.starting.add(newHour: asstimatedWorkTime)
                                newTask.asstimatedWorkTime=asstimatedWorkTime
                                //Needs to send back this task at the end of execution
                                    
                                let startTime = newTask.endTime!
                                let endTime = exsitingDay.ending
                                     
                                let freeSpaceDate = exsitingDay.date
                      
                                
                                if(!newTask.endTime!.isEqual(newHour: exsitingDay.ending))
                                {
     
                                    //Create new FreeSpace excluding new task window
                                    createFreeSpace(startTime:startTime , endTime: endTime, date: freeSpaceDate, duration: endTime.subtract(newHour: startTime),fullyOccupiedDay: false)
                                    
                                  
                                }
                                
                                
                                //delete old FS object
                                deleteFreeSpace(freeSpaceId: exsitingDay.id)
                                
                                let startOfDayHour = Hour(context: managedContext)
                                startOfDayHour.hour=startOfTheDay
                                startOfDayHour.minutes=0
                                
                                let endOfDayHour = Hour(context: managedContext)
                                 endOfDayHour.hour=endOfTheDay
                                 endOfDayHour.minutes=0
                                
                                let newDuration = Hour(context: managedContext)
                                   endOfDayHour.hour=0
                                   endOfDayHour.minutes=0
                                //Create new FS with fullyOccupied flag
                                createFreeSpace(startTime:startOfDayHour , endTime: endOfDayHour, date: freeSpaceDate, duration:newDuration,fullyOccupiedDay: true)
                                
                                return newTask
                                
                            }
                            else{//create new freeSpace object for that day that have no freeSpace object at all, from begining to end of day,excluding task window.
                                
                                //In other words, needs to create task object and restrict FreeSpace Object,FS object will be for all day except the task duration window, see notebook !!!!!!
                                
                                
                                let startOfDayHour = Hour(context: managedContext)
                                  startOfDayHour.hour=startOfTheDay
                                  startOfDayHour.minutes=0
                                                       
                                let endOfDayHour = Hour(context: managedContext)
                                  endOfDayHour.hour=endOfTheDay
                                  endOfDayHour.minutes=0
                                
                                let newTask = Task(context: managedContext)
                                    newTask.taskName=taskName
                                    newTask.dueDate=dueDate
                                    newTask.date!=singleDate
                                    newTask.startTime=startOfDayHour
                                    newTask.endTime=startOfDayHour.add(newHour: asstimatedWorkTime)
                                    newTask.asstimatedWorkTime=asstimatedWorkTime
                                
               
                                
                                //Needs to check if it's not a huge new task that actually takes all day, then the fullyOccuipiedDay should change and can't just be a default false.
                                if(!newTask.endTime!.isEqual(newHour: endOfDayHour))//If it's a full day task
                                {
                                createFreeSpace(startTime: newTask.endTime!, endTime: endOfDayHour, date: singleDate, duration: endOfDayHour.subtract(newHour: newTask.endTime!),fullyOccupiedDay: true)
                                }
                                else{//If there is any free space
                                    createFreeSpace(startTime: newTask.endTime!, endTime: endOfDayHour, date: singleDate, duration: endOfDayHour.subtract(newHour: newTask.endTime!),fullyOccupiedDay: false)
                                }
                                
                                 return newTask
                            }
                            
                        }
                      
                     
                                               
                         }
                                              
                         catch
                         {
                            print(error)
                         }
                                  
                        //Shouldn't get here, if we do, return an empty task. Needs to check how to properly handle this.
                        return Task()
        //Needs to return task object to the calling precedure (probably from the Model, or ViewModel)
    }
    
    
    
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
    
   func createCalanderSequence(startDate:CustomDate,endDate:CustomDate) -> [CustomDate]
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [CustomDate] ()}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        var dateSequence=[CustomDate]()
               var currentIndexDate:CustomDate
               var startOfMonthIndex:Int
        
        currentIndexDate=startDate
        
        while(currentIndexDate.year < endDate.year)
        {
            while(currentIndexDate.month < 13)
            {
                for day in currentIndexDate.day...currentIndexDate.endOfMonth.day
                {
                    let newDate = CustomDate(context:managedContext)
                        newDate.year=currentIndexDate.year
                        newDate.month=currentIndexDate.month
                        newDate.day=day
                    
                      dateSequence.append(newDate)
                                                             
               }
                currentIndexDate.day=1
                currentIndexDate.month+=1
            }
            
            currentIndexDate.month=1
            currentIndexDate.year+=1
        }
        //Same year
        
        while(currentIndexDate.month < endDate.month)
        {
             for day in currentIndexDate.day...currentIndexDate.endOfMonth.day
              {
                
                let newDate = CustomDate(context:managedContext)
                               newDate.year=currentIndexDate.year
                               newDate.month=currentIndexDate.month
                               newDate.day=day
                
                dateSequence.append(newDate)
                                                                 
              }
                currentIndexDate.day=1
                currentIndexDate.month+=1
        }
        //Same month
        for day in currentIndexDate.day...endDate.day
        {
            let newDate = CustomDate(context:managedContext)
                                        newDate.year=currentIndexDate.year
                                        newDate.month=currentIndexDate.month
                                        newDate.day=day
            
              dateSequence.append(newDate)
                                                                           
        }
       
        return dateSequence
     

    }
    
    func createCalanderSequence(startDay:Int,startMonth:Int,startYear:Int,endDay:Int,endMonth:Int,endYear:Int)
       {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           
            let managedContext = appDelegate.persistentContainer.viewContext
           
            let startDate = CustomDate(context:managedContext)
              startDate.year=startYear
              startDate.month=startMonth
              startDate.day=startDay
        
            let endDate = CustomDate(context:managedContext)
               endDate.year=endYear
               endDate.month=endMonth
               endDate.day=endDay
            
           var dateSequence=[CustomDate]()
                  var currentIndexDate:CustomDate
                  var startOfMonthIndex:Int
           
           currentIndexDate=startDate
           
           while(currentIndexDate.year < endDate.year)
           {
               while(currentIndexDate.month < 13)
               {
                   for day in currentIndexDate.day...currentIndexDate.endOfMonth.day
                   {
                       let newDate = CustomDate(context:managedContext)
                           newDate.year=currentIndexDate.year
                           newDate.month=currentIndexDate.month
                           newDate.day=day
                       
                         dateSequence.append(newDate)
                                                                
                  }
                   currentIndexDate.day=1
                   currentIndexDate.month+=1
               }
               
               currentIndexDate.month=1
               currentIndexDate.year+=1
           }
           //Same year
           
           while(currentIndexDate.month < endDate.month)
           {
                for day in currentIndexDate.day...currentIndexDate.endOfMonth.day
                 {
                   
                   let newDate = CustomDate(context:managedContext)
                                  newDate.year=currentIndexDate.year
                                  newDate.month=currentIndexDate.month
                                  newDate.day=day
                   
                   dateSequence.append(newDate)
                                                                    
                 }
                   currentIndexDate.day=1
                   currentIndexDate.month+=1
           }
           //Same month
           for day in currentIndexDate.day...endDate.day
           {
               let newDate = CustomDate(context:managedContext)
                                           newDate.year=currentIndexDate.year
                                           newDate.month=currentIndexDate.month
                                           newDate.day=day
               
                 dateSequence.append(newDate)
                                                                              
           }
          
           for data in dateSequence
           {
               print("D: ",data.day,"M: ",data.month,"Y: ",data.year)
           }

       }
    
    func deleteFreeSpace(freeSpaceId : UUID){
           
           
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           
         
            let managedContext = appDelegate.persistentContainer.viewContext
           
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FreeSpace")
            fetchRequest.predicate = NSPredicate(format: "Id = %@", freeSpaceId as CVarArg)
          
           do
           {
               let requiredFS = try managedContext.fetch(fetchRequest)
               
               let objectToDelete = requiredFS [0] as! NSManagedObject
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
    
    func createFreeSpace(startTime:Hour, endTime:Hour,date:CustomDate,duration:Hour,fullyOccupiedDay:Bool){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              
              //Now let’s create an entity and new user records.
              let freeTimeSpaceEntity = NSEntityDescription.entity(forEntityName: "FreeSpace", in: managedContext)!
              
              //final, we need to add some data to our newly created record for each keys using
              //here adding 5 data with loop
               let timeByHourEntity = NSEntityDescription.entity(forEntityName: "Hour", in: managedContext)!
                
                let startsIn = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                startsIn.setValue(startTime.hour, forKeyPath: "hour")
                startsIn.setValue(startTime.minutes, forKeyPath: "minutes")
        
                       let endsIn = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                        endsIn.setValue(endTime.hour, forKeyPath: "hour")
                        endsIn.setValue(endTime.minutes, forKeyPath: "minutes")
        
                let durationTime = NSManagedObject(entity: timeByHourEntity, insertInto: managedContext)
                endsIn.setValue(duration.hour, forKeyPath: "hour")
                endsIn.setValue(duration.minutes, forKeyPath: "minutes")
                              
        
                let freeSpace = NSManagedObject(entity: freeTimeSpaceEntity, insertInto: managedContext)
                freeSpace.setValue(date.day, forKeyPath: "day")
                freeSpace.setValue(date.month, forKeyPath: "month")
                freeSpace.setValue(date.year, forKeyPath: "year")
                freeSpace.setValue(startsIn, forKeyPath: "starting")
                freeSpace.setValue(endsIn, forKeyPath: "ending")
                freeSpace.setValue(durationTime, forKeyPath: "duration")
                freeSpace.setValue(UUID(), forKeyPath: "id")
                freeSpace.setValue(fullyOccupiedDay, forKeyPath: "fullyOccupiedDay")
        
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
    
    var month: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        return Int(dateFormatter.string(from: self)) ?? 0
    }
    var day: Int {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd"
         return Int(dateFormatter.string(from: self)) ?? 0
     }
    var year: Int {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy"
         return Int(dateFormatter.string(from: self)) ?? 0
     }
    
    var endOfMonth: Date {
          var components = DateComponents()
          components.month = 1
          components.second = -1
          return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
      }
    
    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }
    
    func dayOfWeek() -> String? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           return dateFormatter.string(from: self).capitalized
          
       }//Get value by : "Date().dayOfWeek()!"
    
}


    
    
    
    

