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
        var calanderSequence:[CustomDate]
        
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Task()}
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            

                        
                let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeSpace")
        
        
                    fetchRequest.predicate = NSPredicate(format: "date.year >= %@", argumentArray: [dueDate.year])
                                  
                              
                    do
                    {
                        let results = try managedContext.fetch(fetchRequest)
                        
                        if (results.count == 0)
                        {
                            print("FreeSpace is at count of 0 ")
                            
                            let thisMoment = CustomDate(context:managedContext)
                                                      
                                thisMoment.year=Date().year
                                thisMoment.month=Date().month
                                thisMoment.day=Date().day
                                                  
                            let endDueDate = CustomDate(context:managedContext)
                                endDueDate.year=dueDate.year
                                endDueDate.month=dueDate.month
                                endDueDate.day=dueDate.day
                                                  
                            calanderSequence = createCalanderSequence(startDate:thisMoment, endDate: endDueDate)
                            
                            let zeroDate = CustomDate(context: managedContext)
                                zeroDate.day=0
                                zeroDate.month=0
                                zeroDate.year=0000
                            
                            
                            let singleDate=calanderSequence[0]
                            
                            
                            
                            /*this statment in this annotation is not always correct !!:
                             
                            let singleDate=calanderSequence.first(where: {$0.day <= dueDate.day && $0.month <= dueDate.month && $0.year <= dueDate.year}) ?? zeroDate
                            */
                            
                                   
                                    let startOfDayHour = Hour(context: managedContext)
                                        startOfDayHour.hour=startOfTheDay
                                        startOfDayHour.minutes=0
                                                                              
                                    let endOfDayHour = Hour(context: managedContext)
                                        endOfDayHour.hour=endOfTheDay
                                        endOfDayHour.minutes=0
                                                       
                                    let newTask = Task(context: managedContext)
                                        newTask.taskName=taskName
                                        newTask.dueDate=dueDate
                                        newTask.date=singleDate
                                        newTask.startTime=startOfDayHour
                                        newTask.endTime=startOfDayHour.add(newHour: asstimatedWorkTime)
                                        newTask.asstimatedWorkTime=asstimatedWorkTime
                                        newTask.completed=false
                                        newTask.color="Green"
                                        newTask.active=true
                                        newTask.importance=importance
                                        newTask.notes=notes
                                        newTask.id=UUID()
                            
                            print(newTask.taskName)
                                                       
                                    //Needs to check if it's not a huge new task that actually takes all day, then the fullyOccuipiedDay should change and can't just be a default false.
                                    if(newTask.endTime!.isEqual(newHour: endOfDayHour))//If it's a full day task
                                    {
                                            var durationCalc=endOfDayHour.subtract(newHour: newTask.endTime!)
                                                                                      
                                            print("duration calc: ",durationCalc.hour,":",durationCalc.minutes)
                                        
                                        createFreeSpace(task:newTask,startTime: newTask.endTime!, endTime: endOfDayHour, date: singleDate, duration: endOfDayHour.subtract(newHour: newTask.endTime!),fullyOccupiedDay: true)
                                    }
                                    else{//If there is any free space
                                        
                                        var durationCalc=endOfDayHour.subtract(newHour: newTask.endTime!)
                                                
                                        print("duration calc: ",durationCalc.hour,":",durationCalc.minutes)
                                        
                                            createFreeSpace(task:newTask,startTime: newTask.endTime!, endTime: endOfDayHour, date: singleDate, duration: endOfDayHour.subtract(newHour: newTask.endTime!),fullyOccupiedDay: false)
                                    }
                                                       
                                    return newTask
                            
                        }else{
                            
                            
                          for result in results as! [NSManagedObject] {

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
                                //print(freeDay.date.day," ",freeDay.date.month)
                                if (dueDate.year < freeDay.date.year)//If it's a future year then any date relevent
                                {
                                      suitableFreeDays.append(freeDay)
                                    /*print("Item:",String(freeDay.date.day)," ",String(freeDay.date.month)," ",String(freeDay.date.year))*/
                                }
                                else if(dueDate.year == freeDay.date.year && freeDay.date.month <= dueDate.month)//If it's the same year (so it won't be any past year in time) then check if it's a future or same month and not a past month.
                                {
                                    //print("entered b1")
                                    if(( freeDay.date.day <= dueDate.day && dueDate.month == freeDay.date.month) || (freeDay.date.month < dueDate.month) )//If it's the same month, check for day, if it's a future month then all dates are relevent
                                    {
                                        suitableFreeDays.append(freeDay)
                                       // print("entered b2")
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
                        
                        for singleDate in calanderSequence//Iterate on the sequance of available day
                        {
                           // print("a1",singleDate)
                           // print(suitableFreeDays[0].date)
                            //print("here to save the day from big a")
                            if(suitableFreeDays.contains(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day)} ) )//Check if we already have a FreeSpace object in that date, can't check if the duration in sufficient since this else case goes to create a new FreeSpace object for that day, assuming this term hasn't satisfied only because such an object doesn't exist at all and not because it doesn't match the duration needs. We will check this condition in the next if.
                            {
                               // print("entred d1")
                                let exsitingFreeDay=suitableFreeDays.first(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day) })! //Contains closest FreeSpace slot
                                
                               /* print("entered d2")
                                print(String(exsitingFreeDay.duration.hour))
                                print(asstimatedWorkTime.hour)
                                
                                print("asstimated",asstimatedWorkTime)
                                print("flag"+String(exsitingFreeDay.fullyOccupiedDay))*/
                                
                                if(exsitingFreeDay.duration.isBiggerOrEqual(newHour: asstimatedWorkTime) && exsitingFreeDay.fullyOccupiedDay==false)
                                {
                                
                                    //print("entered d3")
                                        //Create task
                                        
                                        let newTask = Task(context: managedContext)
                                        newTask.taskName=taskName
                                        newTask.dueDate=dueDate
                                        newTask.date=exsitingFreeDay.date
                                        newTask.startTime=exsitingFreeDay.starting
                                        newTask.endTime=exsitingFreeDay.starting.add(newHour: asstimatedWorkTime)
                                        newTask.asstimatedWorkTime=asstimatedWorkTime
                                        newTask.completed=false
                                        newTask.color="Pink"
                                        newTask.active=true
                                        newTask.importance=importance
                                        newTask.notes=notes
                                        newTask.id=UUID()
                                        
                                        //Needs to send back this task at the end of execution
                                            
                                        let startTime = newTask.endTime!
                                        let endTime = exsitingFreeDay.ending
                                             
                                        let freeSpaceDate = exsitingFreeDay.date
                              
                                        
                                        if(!newTask.endTime!.isEqual(newHour: exsitingFreeDay.ending))
                                        {
                                            var durationCalc=endTime.subtract(newHour: startTime)
                                           
                                            print("duration calc: ",durationCalc.hour,":",durationCalc.minutes)
                                            //Create new FreeSpace excluding new task window
                                            createFreeSpace(task:newTask,startTime:startTime , endTime: endTime, date: freeSpaceDate, duration: endTime.subtract(newHour: startTime),fullyOccupiedDay: false)
                                            
                                              deleteFreeSpace(freeSpaceId: exsitingFreeDay.id)
                                          
                                        }
                                        
                                        else{//If the day is now fully occupied
                                            //delete old FS object
                                            deleteFreeSpace(freeSpaceId: exsitingFreeDay.id)
                                            
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
                                        }
                                        return newTask
                                }
                            }
                            else{//If there is no FreeSpace object for that day, create one
                                
                                
                                let startOfDayHour = Hour(context: managedContext)
                                  startOfDayHour.hour=startOfTheDay
                                  startOfDayHour.minutes=0
                                                       
                                let endOfDayHour = Hour(context: managedContext)
                                  endOfDayHour.hour=endOfTheDay
                                  endOfDayHour.minutes=0
                                
                                let newTask = Task(context: managedContext)
                                    newTask.taskName=taskName
                                    newTask.dueDate=dueDate
                                    newTask.date=singleDate
                                    newTask.startTime=startOfDayHour
                                    newTask.endTime=startOfDayHour.add(newHour: asstimatedWorkTime)
                                    newTask.asstimatedWorkTime=asstimatedWorkTime
                                    newTask.completed=false
                                    newTask.color="Blue"
                                    newTask.active=true
                                    newTask.importance=importance
                                    newTask.notes=notes
                                    newTask.id=UUID()
               
                                
                                //Needs to check if it's not a huge new task that actually takes all day, then the fullyOccuipiedDay should change and can't just be a default false.
                                
                                //**Refactoring needed, the only reliable method to check that is by checking the task duration against the day duration (startOfDay-endOfDay)
                                if(newTask.endTime!.isEqual(newHour: endOfDayHour))//If it's a full day task
                                {
                                    createFreeSpace(task:newTask,startTime: newTask.endTime!, endTime: endOfDayHour, date: singleDate, duration: endOfDayHour.subtract(newHour: newTask.endTime!),fullyOccupiedDay: true)
                                }
                                else{//If there is any free space
                                    createFreeSpace(task:newTask,startTime: newTask.endTime!, endTime: endOfDayHour, date: singleDate, duration: endOfDayHour.subtract(newHour: newTask.endTime!),fullyOccupiedDay: false)
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
       
      /*  for data in dateSequence
        {
            print("D: ",data.day,"M: ",data.month,"Y: ",data.year)
        }*/
        
        return dateSequence
     

    }
    
    func createCalanderSequence(startDay:Int,startMonth:Int,startYear:Int,endDay:Int,endMonth:Int,endYear:Int)-> [CustomDate]
       {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [CustomDate]() }
           
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
          
        /*   for data in dateSequence
           {
               print("D: ",data.day,"M: ",data.month,"Y: ",data.year)
           }*/
        
        return dateSequence

       }
    
    func deleteFreeSpace(freeSpaceId : UUID){
           
           
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           
         
            let managedContext = appDelegate.persistentContainer.viewContext
           
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FreeSpace")
            fetchRequest.predicate = NSPredicate(format: "id = %@", freeSpaceId as CVarArg)
          
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
    
    func createFreeSpace(task:Task,startTime:Hour, endTime:Hour,date:CustomDate,duration:Hour,fullyOccupiedDay:Bool){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              

                              
        
                let freeSpace = FreeSpace(context: managedContext)
                freeSpace.date=date
                freeSpace.starting=startTime
                freeSpace.ending=endTime
                freeSpace.duration=duration
                freeSpace.id=UUID()
                freeSpace.fullyOccupiedDay=fullyOccupiedDay
        
                
                print("Task Status: ")
                print(task.taskName)
                print("Duration ",task.asstimatedWorkTime.hour,":",task.asstimatedWorkTime.minutes)
                print("Start Time ",task.startTime!.hour,":",task.startTime!.minutes)
                print("End Time ",task.endTime!.hour,":",task.endTime!.minutes)
                
                print("FreeSpace Status: ")
                print("Duration ",duration.hour,":",duration.minutes)
                print("Start Time ",startTime.hour,":",startTime.minutes)
                print("End Time ",endTime.hour,":",endTime.minutes)
                
              //Now we have set all the values. The next step is to save them inside the Core Data
              
              do {
                  try managedContext.save()
                      print("Saved Free Space !.")
              } catch let error as NSError {
                  print("Could not save. \(error), \(error.userInfo)")
              }
        
        
    }
    
    func createFreeSpace(startTime:Hour, endTime:Hour,date:CustomDate,duration:Hour,fullyOccupiedDay:Bool){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              

                              
        
                let freeSpace = FreeSpace(context: managedContext)
                freeSpace.date=date
                freeSpace.starting=startTime
                freeSpace.ending=endTime
                freeSpace.duration=duration
                freeSpace.id=UUID()
                freeSpace.fullyOccupiedDay=fullyOccupiedDay
        
            
        
              //Now we have set all the values. The next step is to save them inside the Core Data
              
              do {
                  try managedContext.save()
                      print("Saved Free Space !.")
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
             /*  print("Name: ")
               print(result.value(forKey: "assignedTaskName") as! String)
                print("startTime: ")
                   print(result.value(forKey: "startTime")!)*/
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


    
    
    
    

