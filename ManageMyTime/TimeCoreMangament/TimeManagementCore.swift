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
    
    let shortBreakPeriod = 15
    let mediumBreakPeriod = 30
    let longBreakPeriod = 60
    
    let defaultTasksSeperationBreak = 10
    
    enum coreError: Error {
           case dayOfCurrentDayIsZero
           case badPassword
       }
    
    
    enum scheduleAlgorithm:String {
              
            case verySpacious
            case spacious
            case mediumDensity
            case dense
            case veryDense
            case maximumCapacity
     
    }

    
   
    func ScheduleTask(taskName:String,importance:String,asstimatedWorkTime:Hour,dueDate:Date,notes:String,color:String) -> Task
    {
        
        let todayDay = Date().day
        var retrivedFreeDays = [FreeTaskSpace]()
        var suitableFreeSpaces = [FreeTaskSpace]()
        var calanderSequence:[CustomDate]
        

            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Task()}
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            var currentHour = Hour(context: managedContext)
            currentHour.hour=Date().hour
            currentHour.minutes=Date().minutes
            
            currentHour.add(minutesValue: 15)
            
            let startOfDayHour = Hour(context: managedContext)
               startOfDayHour.hour=startOfTheDay
               startOfDayHour.minutes=0
                                                           
            let endOfDayHour = Hour(context: managedContext)
               endOfDayHour.hour=endOfTheDay
               endOfDayHour.minutes=0
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: dueDate)
            let dueHours = components.hour ?? 0
            let dueMinutes = components.minute ?? 0
            
            let dueHour = Hour(context: managedContext)
                dueHour.hour=dueHours
                dueHour.minutes=dueMinutes
                        
                let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
        
        
                    fetchRequest.predicate = NSPredicate(format: "date.year >= %@", argumentArray: [dueDate.year])
                                  
                              
                    do
                    {
                        let results = try managedContext.fetch(fetchRequest)
                        
                  
                            
                            
                          for result in results as! [NSManagedObject] {

                                let spaceObj = result as! FreeTaskSpace
                            
                                retrivedFreeDays.append(spaceObj)
                                
                           }
                    }
                    catch
                    {
                        print(error)
                    }
                        
                           //retrivedFreeDays.sort{ $0.day == $1.day ? $0.day < $1.day : $0.month < $1.month } not good, it's only two arguments
                            
                            
                       
                        
                        
                        let currentDate = CustomDate(context:managedContext)
                            
                        currentDate.year=Date().year
                        currentDate.month=Date().month
                        currentDate.day=Date().day
        
                        print(Date().day)
        
                        let endDueDate = CustomDate(context:managedContext)
                        endDueDate.year=dueDate.year
                        endDueDate.month=dueDate.month
                        endDueDate.day=dueDate.day
                        
                        calanderSequence = createCalanderSequence(startDate:currentDate, endDate: endDueDate)
                        suitableFreeSpaces=retriveAndSortFreeSpaces(currentDate:currentDate,dueDate: dueDate)
        
                        for singleDate in calanderSequence//Iterate on the sequance of available day
                        {
                            var determination=densityHandler(date: singleDate, algorithm: scheduleAlgorithm.maximumCapacity, includePersonalTime: false)
                            if(determination)
                            {
                                
                               // print("a1",singleDate)
                               // print(suitableFreeDays[0].date)
                                //print("here to save the day from big a")
                                if(!suitableFreeSpaces.contains(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day)} ) )//If there is no freeSpace objuect for that day, create one
                                {
                                    
                                    scheduleFreeSpace(date: singleDate)
                                    suitableFreeSpaces=retriveAndSortFreeSpaces(currentDate:currentDate,dueDate: dueDate)
                                }
                                
                                if(suitableFreeSpaces.contains(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day)} ) )//Check if we already have a FreeSpace object in that date, can't check if the duration in sufficient since this else case goes to create a new FreeSpace object for that day, assuming this term hasn't satisfied only because such an object doesn't exist at all and not because it doesn't match the duration needs. We will check this condition in the next if.
                                {
                                    
                                    var matchingFreeSpaces=suitableFreeSpaces.all(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day)} )
                                    
                                   // print("entred d1")
                                    for freeSpace in matchingFreeSpaces
                                    {
                                       // let freeDay=suitableFreeDays.first(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day) })! //Contains closest FreeSpace slot
                                        
                                       /* print("entered d2")
                                        print(String(exsitingFreeDay.duration.hour))
                                        print(asstimatedWorkTime.hour)
                                        
                                        print("asstimated",asstimatedWorkTime)
                                        print("flag"+String(exsitingFreeDay.fullyOccupiedDay))*/
                                        
                                    
                    
                                        if(freeSpace.duration.isBiggerOrEqual(newHour: asstimatedWorkTime)/* && exsitingFreeDay.fullyOccupiedDay==false*/)
                                        {
                                            
                                            if(freeSpace.ending > currentHour && freeSpace.ending.subtract(newHour: currentHour) >= asstimatedWorkTime && freeSpace.starting < currentHour || freeSpace.starting > currentHour && freeSpace.duration >= asstimatedWorkTime ||/*added this after bug no 6D ,needs checking*/ freeSpace.starting == currentHour && freeSpace.duration >= asstimatedWorkTime /*until here*/|| singleDate > currentDate)
                                            {//The if checks and handles dueDate (day,month,year) calculation
                                                print(dueHour)
                                                if(endDueDate > singleDate || singleDate > currentDate && endDueDate == singleDate && freeSpace.starting.add(newHour: asstimatedWorkTime) <= dueHour || singleDate == currentDate && endDueDate == singleDate && currentHour.add(newHour: asstimatedWorkTime) <= dueHour)
                                                {//The if checks and handle dueHour (hour and minutes) calculation
                                          
                                                        print("Here")
                                                        print(freeSpace.duration)
                                                        print(freeSpace.starting)
                                                        print(freeSpace.ending)
                                                        print(freeSpace.ending.hour)
                                                    print(freeSpace.date.day)
                                                    
                                                //print("entered d3")
                                                    //Create task
                                                    
                                                    let newTask = Task(context: managedContext)
                                                    newTask.taskName=taskName
                                                    newTask.dueDate=dueDate
                                                    newTask.date=freeSpace.date
                                                    
                                                    if(freeSpace.date.day==24 && freeSpace.starting.hour==19)
                                                    {
                                                        print("here")
                                                    }
                                                    if(singleDate > currentDate)//if it's a following day, just start from the begining of free space.
                                                    {
                                                        newTask.startTime=freeSpace.starting
                                                    }
                                                    else{//If we can schedule at the same day
                                                        if(currentHour < startOfDayHour)//If the task scheduled before the start of day (at night) then schedule for the start of free space.
                                                        {
                                                            newTask.startTime=freeSpace.starting
                                                        }
                                                        else//If the task scheduled after or in the beginning of day, schedule from the current hour
                                                        {
                                                            if(freeSpace.starting > currentHour)
                                                            {
                                                                newTask.startTime=freeSpace.starting
                                                            }
                                                            else
                                                            {
                                                             newTask.startTime=currentHour
                                                            }
                                                        }
                                                  
                                                      
                                                    }
                                                    
                                                    newTask.endTime=newTask.startTime!.add(newHour: asstimatedWorkTime)
                                                    newTask.asstimatedWorkTime=asstimatedWorkTime
                                                    newTask.completed=false
                                                    newTask.color=color
                                                    newTask.active=true
                                                    newTask.importance=importance
                                                    newTask.notes=notes
                                                    newTask.id=UUID()
                                                    
                                                    handleLoad(date: newTask.date, duration: newTask.endTime!.subtract(newHour: newTask.startTime!))
                                                    
                                                    //Needs to send back this task at the end of execution
                                                        
                                                    let startTime = newTask.endTime!
                                                    let endTime = freeSpace.ending
                                                    
                                                    
                                                    
                                                    let freeSpaceDate = freeSpace.date
                                          
                                                    
                                                    if(!newTask.endTime!.isEqual(newHour: freeSpace.ending))
                                                    {//Handle deletion of old freeSpace and handling the new window of freeSpace
                                                        var durationCalc=endTime.subtract(newHour: startTime)
                                                       
                                                        print("duration calc: ",durationCalc.hour,":",durationCalc.minutes)
                                                        //Create new FreeSpace excluding new task window
                                                        createFreeSpace(task:newTask,startTime:startTime , endTime: endTime, date: freeSpaceDate, duration: endTime.subtract(newHour: startTime),fullyOccupiedDay: false)
                                                        
                                                        
                                                          deleteFreeSpace(freeSpaceId: freeSpace.id)
                                                      
                                                    }
                                                    
                                                    else{//If the day is now fully occupied
                                                        //delete old FS object
                                                        deleteFreeSpace(freeSpaceId: freeSpace.id)
                                                        
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
                                        }
                                    }
                                }
                            }
                           /* else{//If there is no FreeSpace object for that day, create one
                                
                              
                                  
                                  if(endOfDayHour.subtract(newHour: currentHour) >= asstimatedWorkTime || singleDate > currentDate)
                                  {
                                      
                                  
                                  let newTask = Task(context: managedContext)
                                      newTask.taskName=taskName
                                      newTask.dueDate=dueDate
                                      newTask.date=singleDate
                                      if(singleDate > currentDate)//In case a following day have the appropriate requirements for the task (end of day, and workTime)
                                      {
                                          newTask.startTime=startOfDayHour
                                      }
                                      else//In case the same day have the appropriate requirements for the task (end of day, and workTime)
                                      {
                                          if(currentHour < startOfDayHour)//If the task scheduled before the start of day (at night) then schedule for the start of day, which is the current day.
                                            {
                                                newTask.startTime=startOfDayHour
                                            }
                                            else
                                            {
                                                newTask.startTime=currentHour
                                            }
                                     
                                      }
                                      newTask.endTime=newTask.startTime!.add(newHour: asstimatedWorkTime)
                                      newTask.asstimatedWorkTime=asstimatedWorkTime
                                      newTask.completed=false
                                      newTask.color=color
                                      newTask.active=true
                                      newTask.importance=importance
                                      newTask.notes=notes
                                      newTask.id=UUID()
                 
                                  
                                  //Needs to check if it's not a huge new task that actually takes all day, then the fullyOccuipiedDay should change and can't just be a default false.
                                  
                                  //Refactoring needed, the only reliable method to check that is by checking the task duration against the day duration (startOfDay-endOfDay)
                                  if(newTask.endTime!.isEqual(newHour: endOfDayHour))//If it's a full day task
                                  {
                                      createFreeSpace(task:newTask,startTime: newTask.endTime!, endTime: endOfDayHour, date: singleDate, duration: endOfDayHour.subtract(newHour: newTask.endTime!),fullyOccupiedDay: true)
                                  }
                                  else{//If there is any free space
                                      createFreeSpace(task:newTask,startTime: newTask.endTime!, endTime: endOfDayHour, date: singleDate, duration: endOfDayHour.subtract(newHour: newTask.endTime!),fullyOccupiedDay: false)
                                  }
                                  
                                   return newTask
                                    
                            }
                        }*/
                            
                        }
                      
                     
                                               
                        
                                              
                     
                                  
                        //Shouldn't get here, if we do, return an empty task. Needs to check how to properly handle this.
                        return Task()
        //Needs to return task object to the calling precedure (probably from the Model, or ViewModel)
    }
    
    func handleLoad(date:CustomDate,duration:Hour)
    {
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "LoadLevel")
                                              
                          
            fetchRequest.predicate = NSPredicate(format: "date = %@", argumentArray: [date])
                                                    
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
                
                if(loadLevels.isEmpty)
                {
                
                   let loadLevel=LoadLevel(context: managedContext)
                    loadLevel.date=date
                    loadLevel.loadLevel=CGFloat(duration.hourInMinutes())/CGFloat((endOfTheDay-startOfTheDay)*60)

                    loadLevel.id=UUID()
                    
                }
                
                else{
                    
                    loadLevels[0].loadLevel = loadLevels[0].loadLevel+CGFloat(duration.hourInMinutes())/CGFloat((endOfTheDay-startOfTheDay)*60)
                    
                }
        
    }
    
    func densityHandler(date:CustomDate,algorithm:scheduleAlgorithm,includePersonalTime:Bool) -> Bool
     {//Checks if a day is avilable in terms of ideal space regarding the scheduleAlgorithm choise
        
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return true }
         
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
                                                     
                                 
        fetchRequest.predicate = NSPredicate(format: "date.day = %@ AND date.month = %@ AND date.year = %@", argumentArray: [date.day,date.month,date.year])
         
         var isDayAvailable = true
         var scheduledDuration = 0
         var duration:Hour
         var aviliableDayHours = endOfTheDay-startOfTheDay
        
         var tasks = [Task]()
                        
         do
         {
                let results = try managedContext.fetch(fetchRequest)
               
                              
                for result in results as! [NSManagedObject] {

                      let taskObj = result as! Task
                  
                      tasks.append(taskObj)
                      
                 }
          }
             
          catch
          {
              print(error)
          }
         
         tasks.sort {
             ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour) <
                 ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour)
         }
         
         
         for task in tasks
         {
            duration=task.endTime!.subtract(newHour: task.startTime!)
            scheduledDuration=scheduledDuration+duration.hourInMinutes()
 
        }
        
        if(includePersonalTime)
        {
            let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestrictedSpace")
                                                        
                                    
            fetch.predicate = NSPredicate(format: "dayOfTheWeek = %@", argumentArray: [date.dayOfWeek()])
             
             var restrictedSpaces = [RestrictedSpace]()
                                 
              do
              {
                     let results = try managedContext.fetch(fetchRequest)
                    
                                   
                     for result in results as! [NSManagedObject] {

                           let restrictedSpaceObj = result as! RestrictedSpace
                       
                           restrictedSpaces.append(restrictedSpaceObj)
                           
                      }
               }
                  
               catch
               {
                   print(error)
               }
            
            
               for restrictedSpace in restrictedSpaces
                {
                   duration=restrictedSpace.endTime.subtract(newHour: restrictedSpace.startTime)
                   scheduledDuration=scheduledDuration+duration.hourInMinutes()
        
               }
         }
        
            switch algorithm {
            case .verySpacious:
                if(scheduledDuration*100/(aviliableDayHours*60) <= 15)
                {
                    return true
                }
                return false
            case .spacious:
                if(scheduledDuration*100/(aviliableDayHours*60) <= 20)
                 {
                     return true
                 }
                 return false
            case .mediumDensity:
                if(scheduledDuration*100/(aviliableDayHours*60) <= 25)
                 {
                     return true
                 }
                 return false
            case .dense:
                   if(scheduledDuration*100/(aviliableDayHours*60) <= 33)
                    {
                        return true
                    }
                    return false
            case .veryDense:
                    if(scheduledDuration*100/(aviliableDayHours*60) <= 54)
                     {
                         return true
                     }
                     return false
            case .maximumCapacity:
                     return true
            default:
                return true
            }
         
    
        
         
     }
    
   /* func breakConfirmation(suggestedStartHour:Hour,date:CustomDate,algorithm:scheduleAlgorithm) -> Hour
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Hour() }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
                                                    
                                
        fetchRequest.predicate = NSPredicate(format: "date = %@", argumentArray: [date])
        
        var is
        
        var tasks = [Task]()
                       
        do
        {
               let results = try managedContext.fetch(fetchRequest)
              
                             
               for result in results as! [NSManagedObject] {

                     let taskObj = result as! Task
                 
                     tasks.append(taskObj)
                     
                }
         }
            
         catch
         {
             print(error)
         }
        
        tasks.sort {
            ($0.date.year, $0.date.month, $0.date.day,$0.startTime!.hour) <
                ($1.date.year,$1.date.month,$1.date.day,$1.startTime!.hour)
        }
        
        
        
        
        
        
        
    }*/
    
    /*func mergeFreeSpaces()
     {
        
        var dateComponents = DateComponents()
        dateComponents.year = Date().year
        dateComponents.month = Date().month+1
        dateComponents.day = Date().day


        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let dateTime = userCalendar.date(from: dateComponents)!
        
        var sortedFreeSpaces=retriveAndSortFreeSpaces(dueDate:dateTime)
        
        var freeSpacesToDelete=[UUID]()
        
        
        for index in 0...sortedFreeSpaces.count-1
        {
            if(index != sortedFreeSpaces.count-1)
            {
                if(sortedFreeSpaces[index].date==sortedFreeSpaces[index+1].date && sortedFreeSpaces[index].ending == sortedFreeSpaces[index+1].starting)//If it's indeed the same date and this are two sequntial free spaces, in which the second starts in the ending of the first right away
                {
                    
                    print(sortedFreeSpaces[index].ending)
                    print(sortedFreeSpaces[index+1].starting)
                    
                    createFreeSpace(startTime: sortedFreeSpaces[index].starting, endTime: sortedFreeSpaces[index+1].ending, date: sortedFreeSpaces[index].date, duration: sortedFreeSpaces[index+1].ending.subtract(newHour: sortedFreeSpaces[index].starting), fullyOccupiedDay: false)
                      print("on day: " ,sortedFreeSpaces[index+1].date.day,"Creating free space. from: " ,sortedFreeSpaces[index].starting.hour,":",sortedFreeSpaces[index].starting.minutes,"to ",sortedFreeSpaces[index+1].ending.hour,":",sortedFreeSpaces[index+1].ending.minutes)
                    
                    if(!freeSpacesToDelete.contains(sortedFreeSpaces[index].id))//Check if we didn't already order to delete this free space, in case of three or more sequntial FreeSpaces
                    {
                        freeSpacesToDelete.append(sortedFreeSpaces[index].id)
                        print("Ordered to delete ",sortedFreeSpaces[index].id.description)
                        print("on day: " ,sortedFreeSpaces[index].date.day,"delete from: " ,sortedFreeSpaces[index].starting.hour,":",sortedFreeSpaces[index].starting.minutes,"to ",sortedFreeSpaces[index].ending.hour,":",sortedFreeSpaces[index].ending.minutes)
                    }
                    
                    freeSpacesToDelete.append(sortedFreeSpaces[index+1].id)
                    print("Ordered to delete ",sortedFreeSpaces[index+1].id.description)
                    print("on day: " ,sortedFreeSpaces[index+1].date.day," delete from: " ,sortedFreeSpaces[index+1].starting.hour,":",sortedFreeSpaces[index+1].starting.minutes,"to ",sortedFreeSpaces[index+1].ending.hour,":",sortedFreeSpaces[index+1].ending.minutes)
                }
            }
            
        }
        
        for freeSpaceId in freeSpacesToDelete
        {
            print("Going to delete ",freeSpaceId.description)
            deleteFreeSpace(freeSpaceId: freeSpaceId)
        }
        
        
        
         
     }*/
    
    func mergeFreeSpaces(createdFreeSpace:UUID)
    {
       
       var dateComponents = DateComponents()
       dateComponents.year = Date().year
       dateComponents.month = Date().month+1
       dateComponents.day = Date().day


       // Create date from components
       let userCalendar = Calendar.current // user calendar
       let dateTime = userCalendar.date(from: dateComponents)!
       
       var sortedFreeSpaces=retriveAndSortFreeSpaces(dueDate:dateTime)
       
       var freeSpacesToDelete=[UUID]()
        var createdFreeSpaceId=UUID()
        
       var didCreateFreeSpace = false
        
       for index in 0...sortedFreeSpaces.count-1
       {
            if(sortedFreeSpaces[index].id==createdFreeSpace)
           {
            
            
               if(index > 0 && sortedFreeSpaces[index].date==sortedFreeSpaces[index-1].date && sortedFreeSpaces[index].starting == sortedFreeSpaces[index-1].ending)//If it's indeed the same date and this are two sequntial free spaces, in which the second starts in the ending of the first right away
               {
                   didCreateFreeSpace=true
                
                   print(sortedFreeSpaces[index].ending)
                   print(sortedFreeSpaces[index-1].starting)
                   
                    
                   createdFreeSpaceId=createFreeSpace(startTime: sortedFreeSpaces[index-1].starting, endTime: sortedFreeSpaces[index].ending, date: sortedFreeSpaces[index].date, duration: sortedFreeSpaces[index].ending.subtract(newHour: sortedFreeSpaces[index-1].starting), fullyOccupiedDay: false)
                    freeSpacesToDelete.append(createdFreeSpace)
                    freeSpacesToDelete.append(sortedFreeSpaces[index-1].id)
                  
                
               }
                
               if(index+1 <= sortedFreeSpaces.count-1 && sortedFreeSpaces[index].date==sortedFreeSpaces[index+1].date && sortedFreeSpaces[index].ending == sortedFreeSpaces[index+1].starting)
               {
                   if(didCreateFreeSpace)
                   {
                        createFreeSpace(startTime: sortedFreeSpaces[index-1].starting, endTime: sortedFreeSpaces[index+1].ending, date: sortedFreeSpaces[index+1].date, duration: sortedFreeSpaces[index+1].ending.subtract(newHour: sortedFreeSpaces[index-1].starting), fullyOccupiedDay: false)
                        freeSpacesToDelete.append(createdFreeSpaceId)
                    }
                   else{
                      createFreeSpace(startTime: sortedFreeSpaces[index].starting, endTime: sortedFreeSpaces[index+1].ending, date: sortedFreeSpaces[index].date, duration: sortedFreeSpaces[index+1].ending.subtract(newHour: sortedFreeSpaces[index].starting), fullyOccupiedDay: false)
                    }
                
                        if(!freeSpacesToDelete.contains(createdFreeSpace))
                        {
                                freeSpacesToDelete.append(createdFreeSpace)
                        }
                
                        freeSpacesToDelete.append(sortedFreeSpaces[index+1].id)
                    
                
                }
           }
           
       }
       
       for freeSpaceId in freeSpacesToDelete
       {
           print("Going to delete ",freeSpaceId.description)
           deleteFreeSpace(freeSpaceId: freeSpaceId)
       }
       
       
       
        
    }
 
    func retriveAndSortFreeSpaces(currentDate:CustomDate,dueDate:Date) -> [FreeTaskSpace]
    {
        
        var retrivedFreeDays = [FreeTaskSpace]()
        var suitableFreeDays = [FreeTaskSpace]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [FreeTaskSpace]()}
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
              

              fetchRequest.predicate = NSPredicate(format: "date.year >= %@", argumentArray: [Date().year])
        

        
                var dDate = CustomDate(context: managedContext)
                dDate.day=dueDate.day
                dDate.month=dueDate.month
                dDate.year=dueDate.year
                        
              do
              {
                  let results = try managedContext.fetch(fetchRequest)
                  
            
                      
                      
                    for result in results as! [NSManagedObject] {

                          let spaceObj = result as! FreeTaskSpace
                      
                          retrivedFreeDays.append(spaceObj)
                          
                     }
              }
              catch
              {
                  print(error)
              }
                  
             //retrivedFreeDays.sort{ $0.day == $1.day ? $0.day < $1.day : $0.month < $1.month } not good, it's only two arguments
              
              
              //Sort by this order preference: year, month, day
              retrivedFreeDays.sort {
                  ($0.date.year, $0.date.month, $0.date.day,$0.starting.hour) <
                      ($1.date.year,$1.date.month,$1.date.day,$1.starting.hour)
              }
           
              for freeDay in retrivedFreeDays
              
              {//Filter and find relevent future freeSpace days in context to dueDate of the new task
                  //print(freeDay.date.day," ",freeDay.date.month)
                if (freeDay.date <= dDate && freeDay.date >= currentDate)//If it's a future year then any date relevent
                  {
                        suitableFreeDays.append(freeDay)
                      /*print("Item:",String(freeDay.date.day)," ",String(freeDay.date.month)," ",String(freeDay.date.year))*/
                  }

                  
              
              //retrivedFreeDays=retrivedFreeDays.sorted(by:{$0.day > $1.day})//sorted by the rule of $0 item day field is > then somw other $1 item day field
              
              
          }

        return suitableFreeDays
    }
    
    func retriveAndSortFreeSpaces(dueDate:Date) -> [FreeTaskSpace]
       {
           
           var retrivedFreeDays = [FreeTaskSpace]()
           var suitableFreeDays = [FreeTaskSpace]()
           
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [FreeTaskSpace]()}
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
           
           let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
                 

                 fetchRequest.predicate = NSPredicate(format: "date.year >= %@", argumentArray: [Date().year])
           
               let currentDate = CustomDate(context:managedContext)
                                           
                    currentDate.year=Date().year
                    currentDate.month=Date().month
                   currentDate.day=Date().day
           
                   var dDate = CustomDate(context: managedContext)
                   dDate.day=dueDate.day
                   dDate.month=dueDate.month
                   dDate.year=dueDate.year
                           
                 do
                 {
                     let results = try managedContext.fetch(fetchRequest)
                     
               
                         
                         
                       for result in results as! [NSManagedObject] {

                             let spaceObj = result as! FreeTaskSpace
                         
                             retrivedFreeDays.append(spaceObj)
                             
                        }
                 }
                 catch
                 {
                     print(error)
                 }
                     
                //retrivedFreeDays.sort{ $0.day == $1.day ? $0.day < $1.day : $0.month < $1.month } not good, it's only two arguments
                 
                 
                 //Sort by this order preference: year, month, day
                  retrivedFreeDays.sort {
                               ($0.date.year, $0.date.month, $0.date.day,$0.starting.hour) <
                                   ($1.date.year,$1.date.month,$1.date.day,$1.starting.hour)
                           }
              
                 for freeDay in retrivedFreeDays
                 
                 {//Filter and find relevent future freeSpace days in context to dueDate of the new task
                     //print(freeDay.date.day," ",freeDay.date.month)
                     if (freeDay.date <= dDate && freeDay.date >= currentDate)//If it's a future year then any date relevent
                     {
                           suitableFreeDays.append(freeDay)
                         /*print("Item:",String(freeDay.date.day)," ",String(freeDay.date.month)," ",String(freeDay.date.year))*/
                     }

                     
                 
                 //retrivedFreeDays=retrivedFreeDays.sorted(by:{$0.day > $1.day})//sorted by the rule of $0 item day field is > then somw other $1 item day field
                 
                 
             }

           return suitableFreeDays
       }
       
    
    func scheduleFreeSpace (date:CustomDate)
    {
        var retrivedRestrictedSlots = [RestrictedSpace]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                 
         //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let startDayHour = Hour(context: managedContext)
           startDayHour.hour=startOfTheDay
           startDayHour.minutes=0
                                                       
        let endDayHour = Hour(context: managedContext)
            endDayHour.hour=endOfTheDay
            endDayHour.minutes=0
      
        let theZeroHour = Hour(context: managedContext)
            theZeroHour.hour=0
            theZeroHour.minutes=0
            
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestrictedSpace")
       
       
        fetchRequest.predicate = NSPredicate(format: "dayOfTheWeek = %@", argumentArray: [date.dayOfWeek()])
                     
                 
       do
       {
           let results = try managedContext.fetch(fetchRequest)
           
     
               
               
             for result in results as! [NSManagedObject] {

                   let spaceObj = result as! RestrictedSpace
               
                   retrivedRestrictedSlots.append(spaceObj)
                   
              }
        
       }
       catch
       {
           print(error)
       }
        if(retrivedRestrictedSlots.isEmpty)
        {
              let freeSpace = FreeTaskSpace(context: managedContext)
             freeSpace.date=date
             freeSpace.id=UUID()
             freeSpace.starting=startDayHour
             freeSpace.ending=endDayHour
             freeSpace.duration=endDayHour.subtract(newHour: startDayHour)
             freeSpace.fullyOccupiedDay=false
            
            do {
                     try managedContext.save()
                         print("Saved Task !.")
                 } catch let error as NSError {
                     print("Could not save. \(error), \(error.userInfo)")
                 }
        }
        
        for restrictedSlot in retrivedRestrictedSlots
        {
            var existingFreeSpaces = [FreeTaskSpace]()
            
               let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
              
              
               fetchRequest.predicate = NSPredicate(format: "date = %@", argumentArray: [date])
                            
                        
              do
              {
                  let results = try managedContext.fetch(fetchRequest)
                  
            
                      
                      
                    for result in results as! [NSManagedObject] {

                          let spaceObj = result as! FreeTaskSpace
                      
                          existingFreeSpaces.append(spaceObj)
                          
                     }
               
              }
              catch
              {
                  print(error)
              }
      
                  
            if(!existingFreeSpaces.isEmpty)
            {
                for freeSpaceInstance in existingFreeSpaces{
                
         
                    if(restrictedSlot.startTime > freeSpaceInstance.starting && restrictedSlot.endTime < freeSpaceInstance.ending)
                    {
                        
                       
                       let freeSpace = FreeTaskSpace(context: managedContext)
                               freeSpace.date=date
                               freeSpace.id=UUID()
                       
              
                        freeSpace.starting=freeSpaceInstance.starting
                         freeSpace.ending=restrictedSlot.startTime
                         freeSpace.duration=restrictedSlot.startTime.subtract(newHour: freeSpaceInstance.starting)
                         freeSpace.fullyOccupiedDay=false
                         
                         let secondaryFreeSpace=FreeTaskSpace(context: managedContext)
                         
                         secondaryFreeSpace.starting=restrictedSlot.endTime
                         secondaryFreeSpace.ending=freeSpaceInstance.ending
                 
                         secondaryFreeSpace.duration=freeSpaceInstance.ending.subtract(newHour: secondaryFreeSpace.starting)
                         print(freeSpaceInstance.ending.subtract(newHour: secondaryFreeSpace.starting))
                         secondaryFreeSpace.date=date
                         secondaryFreeSpace.fullyOccupiedDay=false
                         secondaryFreeSpace.id=UUID()
                        
                        deleteFreeSpace(freeSpaceId: freeSpaceInstance.id)//Delete old free space since we made changes and created one or two free spaces instead
                                       
                     }
                     else if(restrictedSlot.startTime == freeSpaceInstance.starting && restrictedSlot.endTime == freeSpaceInstance.ending)
                     {
                        
                        deleteFreeSpace(freeSpaceId: freeSpaceInstance.id)
                        
                            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
                                  
                                  
                            fetchRequest.predicate = NSPredicate(format: "date = %@", argumentArray: [date])
                            
                            var availableFreeSpaces=[FreeTaskSpace]()
                                        
                              do
                              {
                                  let results = try managedContext.fetch(fetchRequest)
                                  
                            
                                      
                                      
                                    for result in results as! [NSManagedObject] {

                                          let spaceObj = result as! FreeTaskSpace
                                      
                                          availableFreeSpaces.append(spaceObj)
                                          
                                     }
                               
                              }
                              catch
                              {
                                  print(error)
                              }
                        
                        if(availableFreeSpaces.isEmpty)
                        {
                        
                           let freeSpace = FreeTaskSpace(context: managedContext)
                           freeSpace.date=date
                           freeSpace.id=UUID()
                           freeSpace.starting=startDayHour
                           freeSpace.ending=endDayHour
                           freeSpace.duration=theZeroHour
                           freeSpace.fullyOccupiedDay=true
                        }
                             
                     }
                     else if(restrictedSlot.startTime == freeSpaceInstance.starting)
                     {
                         
   
                           let freeSpace = FreeTaskSpace(context: managedContext)
                           freeSpace.date=date
                           freeSpace.id=UUID()
                           freeSpace.starting=restrictedSlot.endTime
                           freeSpace.ending=freeSpaceInstance.ending
                           freeSpace.duration=freeSpaceInstance.ending.subtract(newHour: freeSpace.starting)
                           print(endDayHour.subtract(newHour: freeSpace.starting))
                           print(freeSpace.duration)
                           freeSpace.fullyOccupiedDay=false
                            
                            deleteFreeSpace(freeSpaceId: freeSpaceInstance.id)//Delete old free space since we made changes and created one or two free spaces instead
                                           
                        
                            
                         
                     }
                     else if (restrictedSlot.endTime == freeSpaceInstance.ending)
                     {
                           let freeSpace = FreeTaskSpace(context: managedContext)
                             freeSpace.date=date
                             freeSpace.id=UUID()
                             freeSpace.starting=freeSpaceInstance.starting
                             freeSpace.ending=restrictedSlot.startTime
                             freeSpace.duration=restrictedSlot.startTime.subtract(newHour: freeSpaceInstance.starting)
                             freeSpace.fullyOccupiedDay=false
                        
                            deleteFreeSpace(freeSpaceId: freeSpaceInstance.id)//Delete old free space since we made changes and created one or two free spaces instead
                                       
                         
                     }
                    
               
                    do {
                           try managedContext.save()
                               print("Saved Free Space !.")
                       } catch let error as NSError {
                           print("Could not save. \(error), \(error.userInfo)")
                       }
                    
                
                }
                
                
            }
                
                
            else{//If there isn't any exsiting free spaces yet
                if(date.day==24)
                {
                    print("here")
                }
                if(restrictedSlot.startTime > startDayHour && restrictedSlot.endTime < endDayHour)
                  {
                               
                    let freeSpace = FreeTaskSpace(context: managedContext)
                            freeSpace.date=date
                            freeSpace.id=UUID()
                    
           
                      freeSpace.starting=startDayHour
                      freeSpace.ending=restrictedSlot.startTime
                      freeSpace.duration=restrictedSlot.startTime.subtract(newHour: startDayHour)
                      freeSpace.fullyOccupiedDay=false
                      
                      let secondaryFreeSpace=FreeTaskSpace(context: managedContext)
                      
                      secondaryFreeSpace.starting=restrictedSlot.endTime
                      secondaryFreeSpace.ending=endDayHour
                      secondaryFreeSpace.duration=endDayHour.subtract(newHour: secondaryFreeSpace.starting)
                      print(endDayHour.subtract(newHour: secondaryFreeSpace.starting))
                      secondaryFreeSpace.date=date
                      secondaryFreeSpace.fullyOccupiedDay=false
                      secondaryFreeSpace.id=UUID()
                  }
                  else if(restrictedSlot.startTime == startDayHour && restrictedSlot.endTime == endDayHour)
                  {
                        let freeSpace = FreeTaskSpace(context: managedContext)
                        freeSpace.date=date
                        freeSpace.id=UUID()
                        freeSpace.starting=startDayHour
                        freeSpace.ending=endDayHour
                        freeSpace.duration=theZeroHour
                        freeSpace.fullyOccupiedDay=true
                          
                  }
                  else if(restrictedSlot.startTime == startDayHour)
                  {
                        let freeSpace = FreeTaskSpace(context: managedContext)
                        freeSpace.date=date
                        freeSpace.id=UUID()
                        freeSpace.starting=restrictedSlot.endTime
                        freeSpace.ending=endDayHour
                        freeSpace.duration=endDayHour.subtract(newHour: freeSpace.starting)
                        print(endDayHour.subtract(newHour: freeSpace.starting))
                        print(freeSpace.duration)
                        freeSpace.fullyOccupiedDay=false
                      
                  }
                  else if (restrictedSlot.endTime == endDayHour)
                  {
                        let freeSpace = FreeTaskSpace(context: managedContext)
                          freeSpace.date=date
                          freeSpace.id=UUID()
                          freeSpace.starting=startDayHour
                          freeSpace.ending=restrictedSlot.startTime
                          freeSpace.duration=restrictedSlot.startTime.subtract(newHour: startDayHour)
                          freeSpace.fullyOccupiedDay=false
                      
                  }
                
                do {
                      try managedContext.save()
                          print("Saved Task !.")
                  } catch let error as NSError {
                      print("Could not save. \(error), \(error.userInfo)")
                  }
            }
              
            
            
        }

        
        
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
                         
                
               
                       let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
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
             
        var startOfMonthIndex:Int
        
        //Seems like a managedContext var is passed by refrence !, when we are moving to a new month for example, the currentIndexDate changes and thus we need to seperate it from the orginal object that the ScheduleTask method uses and create a new seperate object.
        
        var currentIndexDate=CustomDate(context: managedContext)
        currentIndexDate.day=startDate.day
        currentIndexDate.month=startDate.month
        currentIndexDate.year=startDate.year
        
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
           
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FreeTaskSpace")
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
              

                              
        
                let freeSpace = FreeTaskSpace(context: managedContext)
                freeSpace.date=date
                freeSpace.starting=startTime
                freeSpace.ending=endTime
                freeSpace.duration=duration
                freeSpace.id=UUID()
                freeSpace.fullyOccupiedDay=fullyOccupiedDay
        
               /*
                print("Task Status: ")
                print(task.taskName)
                print("Duration ",task.asstimatedWorkTime.hour,":",task.asstimatedWorkTime.minutes)
                print("Start Time ",task.startTime!.hour,":",task.startTime!.minutes)
                print("End Time ",task.endTime!.hour,":",task.endTime!.minutes)
                
                print("FreeSpace Status: ")
                print("Duration ",duration.hour,":",duration.minutes)
                print("Start Time ",startTime.hour,":",startTime.minutes)
                print("End Time ",endTime.hour,":",endTime.minutes)*/
                
              //Now we have set all the values. The next step is to save them inside the Core Data
              
              do {
                  try managedContext.save()
                      print("Saved Free Space !.")
              } catch let error as NSError {
                  print("Could not save. \(error), \(error.userInfo)")
              }
        
        
    }
    
    
    
 
    
    
    func createFreeSpace(startTime:Hour, endTime:Hour,date:CustomDate,duration:Hour,fullyOccupiedDay:Bool) -> UUID{
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return UUID() }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              

                              
        
                let freeSpace = FreeTaskSpace(context: managedContext)
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
        
        return freeSpace.id
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
    
    
    var hour: Int{
        
        let hour = Calendar.current.component(.hour, from: self)
        return Int(hour)
    }
    
    var minutes: Int{
        
        let minutes = Calendar.current.component(.minute, from: self)
        return Int(minutes)
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


    
    
    
    

