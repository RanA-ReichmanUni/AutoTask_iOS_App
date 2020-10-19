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



enum scheduleDensity:String {
          
        case verySpacious
        case spacious
        case mediumDensity
        case dense
        case veryDense
        case extremelyDense
        case maximumCapacity
 
}


enum breakPeriods:String {
            
          case fortyFiveMinutes
          case hourAndAHalf
          case twoHours
          case threeHours
          case fiveHours
          case Continues
   
  }

enum scheduleAlgorithm:String{
    
    case smart
    case optimal
    case advanced
    case earliest
    case latest
    
    
    
    
}

enum difficultyLevel:String{
    
    case difficult
    case average
    case easy
}

enum animationStyle:String{
    
    case smooth
    case fast
    case spring
  
    
}

class Core{
    
    let startOfTheDay = 7
    let endOfTheDay = 22
    
    let shortBreakPeriod = 15
    let mediumBreakPeriod = 30
    let longBreakPeriod = 60
    
    let defaultTasksSeperationBreak = 10
    
    enum coreError: Error {
           case dayOfCurrentDayIsZero
           case multipleFreeSpacesPerDate

       }
    
    enum taskError: Error {
         case noTasksForTheDay

     }
    
    enum scheduleError: Error {
            case couldNotScheduleAllSections
        
        }
       
    
    
    
    

    
   
    
  /*  func scheduleHandler(taskName:String,importance:String,asstimatedWorkTime:Hour,dueDate:Date,notes:String,color:String,scheduleSection:String) throws
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        

        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        var taskSection:Double = 0
        var workTimeMinutes=Double(asstimatedWorkTime.hour*60 + asstimatedWorkTime.minutes)
        var intervals=1
        var currentTaskInternalId=UUID()
        var hourSection = Hour(context: managedContext)

        
        switch scheduleSection {
        case "fortyFiveMinutes":
            taskSection=45
            hourSection.hour=0
            hourSection.minutes=45
            
        case "hourAndAHalf":
            taskSection=105
            hourSection.hour=1
            hourSection.minutes=30
                 
        case "twoHours":
            taskSection=120
            hourSection.hour=2
            hourSection.minutes=0
        case "threeHours":
            taskSection=180
            hourSection.hour=3
            hourSection.minutes=0
        case "Continues":
            isContinues=true
            
              
        default:
            taskSection=105
        }
        
        if(taskSection < workTimeMinutes)
        {
            
            intervals = Int((workTimeMinutes/taskSection).rounded(.up))
            
            
        }
        
        
        
        
        for _ in 0...intervals
        {
            
            
            do {
                  _=try ScheduleTask(taskName: taskName, importance: importance, asstimatedWorkTime: hourSection, dueDate: dueDate, notes: notes ,color:color,internalId:currentTaskInternalId)
            }
           catch{
                throw DatabaseError.taskCanNotBeScheduledInDue
           }
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
    }*/
    
    func breakHandler(date:CustomDate,scheduleSection:String)
    {
             var allTasks=[Task]()
                //As we know that container is set up in the AppDelegates so we need to refer that container.
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
                
                //We need to create a context from this container
                let managedContext = appDelegate.persistentContainer.viewContext
                
                //Prepare the request of type NSFetchRequest  for the entity
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "isTaskBreakWindow = %@ AND date.year = %@ AND date.month = %@ AND date.day = %@",argumentArray: [true,date.year,date.month,date.day])
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
                do {
                    
                    let result = try managedContext.fetch(fetchRequest)
                    if (!result.isEmpty)
                    {
                        
                    }
                    else{
                    
                        for data in result as! [Task] {
                                
                            
                                allTasks.append(data)
            
                       
                        }
                        print("Retrived all tasks !")
                    }
                    
                } catch {
                    
                    print("Failed")
                }
            
        
        
        
        
    }
    
    func DeleteAllByInternalId(internalId:UUID)
    {
           //As we know that container is set up in the AppDelegates so we need to refer that container.
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
              
              //We need to create a context from this container
              let managedContext = appDelegate.persistentContainer.viewContext
              
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
              fetchRequest.predicate = NSPredicate(format: "internalId = %@", internalId as CVarArg)
             
              var freeSpaceId=UUID()
        
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

                    freeSpaceId=createFreeSpace(startTime: task.startTime!, endTime: task.endTime!, date: task.date, duration: task.asstimatedWorkTime, fullyOccupiedDay: false)
                    
                    let objectToDelete = task as! NSManagedObject
                    managedContext.delete(objectToDelete)
                    mergeFreeSpaces(createdFreeSpace:freeSpaceId)
                    
                }
                
                
            
       
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
    
    func GetHourSection() -> SpaceSection
       {
        
          

        
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return SpaceSection() }
            let taskModel=TaskModel()
            let scheduleSection=taskModel.getSettingsValues().breakPeriods
        
           let managedContext = appDelegate.persistentContainer.viewContext
                  
        let hourSection = Hour(context: managedContext)
        let breakSection = Hour(context: managedContext)
        
        
       
        
           var spaceSection=SpaceSection()
        
           switch scheduleSection {
                 case "fortyFiveMinutes":
                   
                     hourSection.hour=0
                     hourSection.minutes=45
                     
                     breakSection.hour=0
                     breakSection.minutes=5
                     
                     spaceSection.breakTime=breakSection
                     spaceSection.sectionWindow=hourSection
            
                 case "hourAndAHalf":
                  
                     hourSection.hour=1
                     hourSection.minutes=30
                       
                     breakSection.hour=0
                     breakSection.minutes=20
                  
                    spaceSection.breakTime=breakSection
                     
                    spaceSection.sectionWindow=hourSection
                          
                 case "twoHours":
                    
                     hourSection.hour=2
                     hourSection.minutes=0
               
                     breakSection.hour=0
                     breakSection.minutes=30
                  
                     spaceSection.breakTime=breakSection
                     
                    spaceSection.sectionWindow=hourSection
            
                 case "threeHours":
                   
                     hourSection.hour=3
                     hourSection.minutes=0
               
                     breakSection.hour=1
                     breakSection.minutes=0
                  
                     spaceSection.breakTime=breakSection
                     
                    spaceSection.sectionWindow=hourSection
            
                case "fiveHours":
                  
                    hourSection.hour=5
                    hourSection.minutes=0
                          
                    breakSection.hour=1
                    breakSection.minutes=30
                             
                    spaceSection.breakTime=breakSection
                                
                    spaceSection.sectionWindow=hourSection
            
                 case "Continues":
                   
            
                    spaceSection.breakTime=nil
                    spaceSection.sectionWindow=nil
                    spaceSection.isContinues=true
                       
                 default:
                  
                     hourSection.hour=1
                     hourSection.minutes=30
                       
                     breakSection.hour=0
                     breakSection.minutes=20
                  
                    spaceSection.breakTime=breakSection
                     
                    spaceSection.sectionWindow=hourSection
                 }
        
            return spaceSection
        
       }
    
    func   ContinuesScheduleHandler(taskName:String,importance:String,asstimatedWorkTime:Hour,dueDate:Date,notes:String,color:String,internalId:UUID,safetyCount:Int) throws
    {
         let count=safetyCount-1
        
        if(safetyCount==0)
        {
            throw DatabaseError.taskCanNotBeScheduledInDue
        }
        
        do{

            _=try ScheduleTask(taskName:taskName,importance:importance,asstimatedWorkTime:asstimatedWorkTime,dueDate:dueDate,notes:notes,color:color,internalId:internalId,safetyCount: count)
            
        
        }
        catch DatabaseError.taskCanNotBeScheduledInDue{
            
            DeleteAllByInternalId(internalId:internalId)
            
            throw DatabaseError.taskCanNotBeScheduledInDue
            
        }
    
        
        
        
    }
    
    func GetTaskEndsWith(date:CustomDate,endsIn:Hour)throws ->  Task
    {
       
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Task()}
               
       //We need to create a context from this container
       let managedContext = appDelegate.persistentContainer.viewContext
       

                   
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
           
           
        fetchRequest.predicate = NSPredicate(format: "date.year = %@ AND date.month = %@ AND date.day = %@ AND endTime.hour = %@ AND endTime.minutes = %@", argumentArray: [date.year,date.month,date.day,endsIn.hour,endsIn.minutes])
        var retrivedTask=Task()
        var isThrow=false
        do {
               
               let result = try managedContext.fetch(fetchRequest)
            
               if (result.isEmpty)
               {
                    isThrow=true
               }
               else{
               
                retrivedTask=result[0] as! Task
                  
               }
               
           } catch {
               
               print("Failed")
           }
        
        if(isThrow)
        {
            throw taskError.noTasksForTheDay
        }
        return retrivedTask
                                     
        
    }
    
    
    func getDifficultyFactor(difficultyPhrase:String) -> Double
    {
        var factorValue=1.5
        
        switch difficultyPhrase.lowercased() {
        case difficultyLevel.difficult.rawValue:
          factorValue=3
        case difficultyLevel.average.rawValue:
          factorValue=1.5
        case difficultyLevel.easy.rawValue:
          factorValue=1
        default:
          factorValue=1.5
        }
        
        
        return factorValue
        
    }
    
    
    func SmartAlgorithm (startDate:CustomDate,endDate:CustomDate) throws -> [CustomDate]
     {
          let taskModel=TaskModel()
          let restrictedSpaceModel=RestrictedSpaceModel()
          
          var priorityDates=[CustomDate]()
          var calendarSequence=[CustomDate]()
        
           do{
                try calendarSequence = createCalanderSequence(startDate:startDate, endDate: endDate)
            }
            catch{
              throw DateBoundsError.dueDateIsInPastTime
            }
          
          
          for singleDate in calendarSequence//Other date FreeSpace Checker
          {
                 let allTasks=taskModel.retrieveTasksByDate(date:singleDate)
                 let allRestrictedSpaces=restrictedSpaceModel.getAllRestrictedSpacesByDate(date:singleDate)
             
              if(allTasks.isEmpty && allRestrictedSpaces.isEmpty)//If there is another date in the range which is completely unoccupied then we would prefer it first.
                {
                  priorityDates.append(singleDate)
                }

          }
      
          
         
          var datesAndTime = [PriorityPerDate]()
      
          for singleDate in calendarSequence//Other date FreeSpace Checker
          {
             let allTasks=taskModel.retrieveTasksByDate(date:singleDate)
             let allRestrictedSpaces=restrictedSpaceModel.getAllRestrictedSpacesByDate(date:singleDate)
             var workTimeRank:Double=0
             
             if(!allTasks.isEmpty || !allRestrictedSpaces.isEmpty)//In order to not insert a day that is not scheduled for ant restrictesSpace or task. In that case if it wasn't for this if statment the day would be inserted to the "datesAndTime" array and eventually to the "priorityDates" array, but since this is an emptySpace day, we already inserted this day. This would have cause the schedule algorithm to check this day twice !.
             {
                  if(!allTasks.isEmpty)
                  {
                      
                          for task in allTasks//Check for summary of minutes of the current date
                          {
                              
                             workTimeRank=workTimeRank+Double(task.asstimatedWorkTime.hourInMinutes())*getDifficultyFactor(difficultyPhrase: task.difficulty)
                              
                          }
                          
                     // datesAndTime.append(WorkPerDate(date: singleDate, timeInMinutes: workTimeSummary))
                  }
                 
                
                 
                 if(!allRestrictedSpaces.isEmpty)
                    {
                       
                            for restrictedSpace in allRestrictedSpaces//Check for summary of minutes of the current date
                            {
                                let duration=restrictedSpace.endTime.subtract(newHour: restrictedSpace.startTime).hourInMinutes()
                                
                             workTimeRank=workTimeRank+Double(duration)*getDifficultyFactor(difficultyPhrase: restrictedSpace.difficulty)
                                
                            }
                            
                        
                    }
                 
                 datesAndTime.append(PriorityPerDate(date: singleDate, rank: workTimeRank))
             }
          }
      
          datesAndTime.sort {
                        ($0.rank!) <
                            ($1.rank!)
                    }//Sort dates by the acttual work time
          
          for singleDate in datesAndTime//Append dates by work load priority
          {
              
              priorityDates.append(singleDate.date!)
              
          
          }
              
              
         return priorityDates
        
    }
     
     func OptimalAlgorithm (startDate:CustomDate,endDate:CustomDate) throws -> [CustomDate]
     {
           let taskModel=TaskModel()
           let restrictedSpaceModel=RestrictedSpaceModel()
           
           var priorityDates=[CustomDate]()
           var calendarSequence=[CustomDate]()
         
            do{
                 try calendarSequence = createCalanderSequence(startDate:startDate, endDate: endDate)
             }
             catch{
               throw DateBoundsError.dueDateIsInPastTime
             }
           
           
           for singleDate in calendarSequence//Other date FreeSpace Checker
           {
                 let allTasks=taskModel.retrieveTasksByDate(date:singleDate)
                 let allRestrictedSpaces=restrictedSpaceModel.getAllRestrictedSpacesByDate(date:singleDate)
                        
                 if(allTasks.isEmpty && allRestrictedSpaces.isEmpty)//If there is another date in the range which is completely unoccupied then we would prefer it first.
                 {
                   priorityDates.append(singleDate)
                 }

           }
       
           
          
           var datesAndTime = [WorkPerDate]()
       
           for singleDate in calendarSequence//Other date FreeSpace Checker
           {
              let allTasks=taskModel.retrieveTasksByDate(date:singleDate)
              let allRestrictedSpaces=restrictedSpaceModel.getAllRestrictedSpacesByDate(date:singleDate)
              var workTimeSummary=0
              
              if(!allTasks.isEmpty || !allRestrictedSpaces.isEmpty)//In order to not insert a day that is not scheduled for ant restrictesSpace or task. In that case if it wasn't for this if statment the day would be inserted to the "datesAndTime" array and eventually to the "priorityDates" array, but since this is an emptySpace day, we already inserted this day. This would have cause the schedule algorithm to check this day twice !.
              {
                   if(!allTasks.isEmpty)
                   {
                       
                           for task in allTasks//Check for summary of minutes of the current date
                           {
                               
                               workTimeSummary=workTimeSummary+task.asstimatedWorkTime.hourInMinutes()
                               
                           }
                           
                      // datesAndTime.append(WorkPerDate(date: singleDate, timeInMinutes: workTimeSummary))
                   }
                  
                 
                  
                  if(!allRestrictedSpaces.isEmpty)
                     {
                        
                             for restrictedSpace in allRestrictedSpaces//Check for summary of minutes of the current date
                             {
                                 let duration=restrictedSpace.endTime.subtract(newHour: restrictedSpace.startTime).hourInMinutes()
                                 
                                 workTimeSummary=workTimeSummary+duration
                                 
                             }
                             
                         
                     }
                  
                  datesAndTime.append(WorkPerDate(date: singleDate, timeInMinutes: workTimeSummary))
              }
           }
       
           datesAndTime.sort {
                         ($0.timeInMinutes!) <
                             ($1.timeInMinutes!)
                     }//Sort dates by the acttual work time
           
           for singleDate in datesAndTime//Append dates by work load priority
           {
               
               priorityDates.append(singleDate.date!)
               
           
           }
               
               
          return priorityDates
         
     }
     
     func AdvancedAlgorithm (startDate:CustomDate,endDate:CustomDate) throws -> [CustomDate]
     {
           let taskModel=TaskModel()
             
             var priorityDates=[CustomDate]()
             var calendarSequence=[CustomDate]()
         
              do{
                     try calendarSequence = createCalanderSequence(startDate:startDate, endDate: endDate)
                 }
                 catch{
                   throw DateBoundsError.dueDateIsInPastTime
                 }
               
               
               for singleDate in calendarSequence//Other date FreeSpace Checker
               {
                 
                     let allTasks=taskModel.retrieveTasksByDate(date:singleDate)
    
                     if(allTasks.isEmpty)//If there is another date in the range which is completely unoccupied then we would prefer it first.
                     {
                       priorityDates.append(singleDate)
                     }
     
               }
           
               
              
               var datesAndTime = [WorkPerDate]()
           
               for singleDate in calendarSequence//Other date FreeSpace Checker
               {
                 let allTasks=taskModel.retrieveTasksByDate(date:singleDate)
                   if(!allTasks.isEmpty)
                   {
                       var workTimeSummary=0
                           for task in allTasks//Check for summary of minutes of the current date
                           {
                               
                               workTimeSummary=workTimeSummary+task.asstimatedWorkTime.hourInMinutes()
                               
                           }
                           
                       datesAndTime.append(WorkPerDate(date: singleDate, timeInMinutes: workTimeSummary))
                   }
               }
           
           datesAndTime.sort {
                         ($0.timeInMinutes!) <
                             ($1.timeInMinutes!)
                     }//Sort dates by the acttual work time
           
           for singleDate in datesAndTime//Append dates by work load priority
           {
               
               priorityDates.append(singleDate.date!)
               
           
           }
               
               
          return priorityDates
         
         
         
     }
    func EarliestAlgorithm (startDate:CustomDate,endDate:CustomDate) throws -> [CustomDate]
    {
    
          var calendarSequence=[CustomDate]()
        
            do{
                 try calendarSequence = createCalanderSequence(startDate:startDate, endDate: endDate)
             }
             catch{
               throw DateBoundsError.dueDateIsInPastTime
             }
               
            return calendarSequence
        
        
    }
    func LatestAlgorithm (startDate:CustomDate,endDate:CustomDate) throws -> [CustomDate]
    {
       
          var calendarSequence=[CustomDate]()
        
            do{
                 try calendarSequence = createCalanderSequence(startDate:startDate, endDate: endDate)
             }
             catch{
               throw DateBoundsError.dueDateIsInPastTime
             }
             
             
             
             calendarSequence.sort {
                             ($0.year, $0.month, $0.day) >
                                 ($1.year,$1.month,$1.day)
                         }//Sort dates by reverse order,latest date first earliest last
             
             
            return calendarSequence
        
    }
    
    func ScheduleAlgorithmEnumConverter(phrase:String) -> scheduleAlgorithm
    {
        
            switch phrase {
              case scheduleAlgorithm.smart.rawValue:
                 return scheduleAlgorithm.smart
              case scheduleAlgorithm.optimal.rawValue:
                  return scheduleAlgorithm.optimal
              case scheduleAlgorithm.advanced.rawValue:
                  return scheduleAlgorithm.advanced
              case scheduleAlgorithm.earliest.rawValue:
                  return scheduleAlgorithm.earliest
              case scheduleAlgorithm.latest.rawValue:
                  return scheduleAlgorithm.latest
              default:
                  return scheduleAlgorithm.smart
            }
        
        
    }
        
    func SchedulingPriorityAlgrorithmDates(startDate:CustomDate,endDate:CustomDate) throws -> [CustomDate]
    {
      
        let taskModel=TaskModel()
        
        let schedulingAlgorithm = ScheduleAlgorithmEnumConverter(phrase:taskModel.getSettingsValues().scheduleAlgorithim)
      
        
        
        switch schedulingAlgorithm {
        case .smart:
          do{
               return try SmartAlgorithm(startDate: startDate, endDate: endDate)
            }
            catch{
                throw DateBoundsError.dueDateIsInPastTime
            }
        case .optimal:
          do{
               return try OptimalAlgorithm(startDate: startDate, endDate: endDate)
            }
            catch{
                throw DateBoundsError.dueDateIsInPastTime
            }
        case .advanced:
         do{
              return try AdvancedAlgorithm(startDate: startDate, endDate: endDate)
           }
           catch{
               throw DateBoundsError.dueDateIsInPastTime
           }
        case .earliest:
          do{
               return try EarliestAlgorithm(startDate: startDate, endDate: endDate)
            }
            catch{
                throw DateBoundsError.dueDateIsInPastTime
            }
        case .latest:
          do{
               return try LatestAlgorithm(startDate: startDate, endDate: endDate)
            }
            catch{
                throw DateBoundsError.dueDateIsInPastTime
            }

        default:
           do{
                return try OptimalAlgorithm(startDate: startDate, endDate: endDate)
             }
             catch{
                 throw DateBoundsError.dueDateIsInPastTime
             }
        }
        
      
    

        
        
    }
    
    
    
    func ScheduleTask(taskName:String,importance:String,asstimatedWorkTime:Hour,dueDate:Date,notes:String,difficulty:String=difficultyLevel.average.rawValue,color:String,notificationFactor:Int=10,internalId:UUID?=nil,safetyCount:Int=30) throws -> Task
    {
      
        
       
        var retrivedFreeDays = [FreeTaskSpace]()
        var suitableFreeSpaces = [FreeTaskSpace]()
        var calanderSequence:[CustomDate]
        var isContinuesScheduling=false
        var remainingWorkTime = Hour()
        var taskInternalId=UUID()
       
        var minimalSpaceExists=false
        
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Task()}
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
        var currentHour = Hour(context: managedContext)
            currentHour.hour=Date().hour
            currentHour.minutes=Date().minutes
            
           // currentHour=currentHour.add(minutesValue: 15)
            
            let minimalSpaceDuration=Hour(context: managedContext)
                minimalSpaceDuration.hour=0
                minimalSpaceDuration.minutes=30
      
            let minimalPartitionSize=Hour(context: managedContext)
                minimalPartitionSize.hour=0
                minimalPartitionSize.minutes=30
        
        
        let breakWindowEndTime = Hour(context: managedContext)
                breakWindowEndTime.hour=0
                breakWindowEndTime.minutes=0
            let breakPeriod = Hour(context: managedContext)
                breakPeriod.hour=0
                breakPeriod.minutes=20
        
            let startOfDayHour = GetStartOfDay()
                                                           
            //let endOfDayHour = GetEndOfDay()
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: dueDate)
            let dueHours = components.hour ?? 0
            let dueMinutes = components.minute ?? 0
            
            let dueHour = Hour(context: managedContext)
                dueHour.hour=dueHours
                dueHour.minutes=dueMinutes
        
            let zeroHour = Hour(context: managedContext)
                     zeroHour.hour=0
                     zeroHour.minutes=0
                        
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
        
                        do{
                            try calanderSequence = SchedulingPriorityAlgrorithmDates(startDate:currentDate, endDate: endDueDate)
                        }
                        catch{
                           throw    DateBoundsError.dueDateIsInPastTime
                        }
        
                        suitableFreeSpaces=retriveAndSortFreeSpaces(currentDate:currentDate,dueDate: dueDate)
        
                        for singleDate in calanderSequence//Iterate on the sequance of available day
                        {
                            let determination=densityHandler(date: singleDate,workTime:asstimatedWorkTime ,includePersonalTime: false)

                          
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
                                    
                                    let matchingFreeSpaces=suitableFreeSpaces.all(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day)} )
                                    
                                   // print("entred d1")
                                    for freeSpace in matchingFreeSpaces
                                    {
                                       // let freeDay=suitableFreeDays.first(where: { singleDate.isEqual(year: $0.date.year, month: $0.date.month, day: $0.date.day) })! //Contains closest FreeSpace slot
                                        
                                       /* print("entered d2")
                                        print(String(exsitingFreeDay.duration.hour))
                                        print(asstimatedWorkTime.hour)
                                        
                                        print("asstimated",asstimatedWorkTime)
                                        print("flag"+String(exsitingFreeDay.fullyOccupiedDay))*/
                                        
                                               
                                        print("duration of free space: "+String(freeSpace.duration.hour)+":"+String(freeSpace.duration.minutes))
                                        print("Free space from"+String(freeSpace.starting.hour)+":"+String(freeSpace.starting.minutes)+" To "+String(freeSpace.ending.hour)+":"+String(freeSpace.ending.minutes))
                                        print("date of freeSpace: "+String(freeSpace.date.day)+"/"+String(freeSpace.date.month))
                                    
                                    
                                        if(/*freeSpace.duration.isBiggerOrEqual(newHour: asstimatedWorkTime*/
                                            !freeSpace.fullyOccupiedDay && (freeSpace.duration > minimalSpaceDuration || freeSpace.duration >= asstimatedWorkTime))
                                            
                                            /* && exsitingFreeDay.fullyOccupiedDay==false)*/
                                        {//Check for freeSpace with at least a minimalTaskDuration standert (so it won't schedule partial task in mininal duration like 4 minutes and so. Or if the reminaing work is fitting the freeSpace anyway except the free space.
                                            
                                            if(freeSpace.ending > currentHour && freeSpace.starting < currentHour || freeSpace.starting > currentHour ||/*added this after bug no 6D ,needs checking*/ freeSpace.starting == currentHour  /*until here*/|| singleDate > currentDate)
                                            {//The if checks and handles dueDate (day,month,year) calculation
                                                print(dueHour)
                                             
                                                if(endDueDate > singleDate || singleDate > currentDate && endDueDate == singleDate && freeSpace.starting.add(hour: asstimatedWorkTime) <= dueHour || singleDate == currentDate && endDueDate == singleDate && currentHour.add(hour: asstimatedWorkTime) <= dueHour)
                                                {//The if checks and handle dueHour (hour and minutes) calculation
                                                    
                                                        print("Here")
                                                        print(freeSpace.duration)
                                                        print(freeSpace.starting)
                                                        print(freeSpace.ending)
                                                        print(freeSpace.ending.hour)
                                                    print(freeSpace.date.day)
                                                    
                                                //print("entered d3")
                                                    //Create task
                                                    if((singleDate == currentDate) && currentHour >= startOfDayHour && freeSpace.starting <= currentHour)//Case we will start for the currentHour (this is the settings that exsits ahead and we just predict if this is the case now in order to check if there is a minimal space in that freeSpace section since we don't start scheduling from the begining of space
                                                       {
    
                                                           if(freeSpace.ending.subtract(newHour: currentHour.subtract(newHour: freeSpace.starting)) >= minimalPartitionSize)
                                                           {
                                                               minimalSpaceExists=true
                                                           }
                                                           else{
                                                               minimalSpaceExists=false
                                                           }
                                                           
                                                           
                                                       }
                                                       else{
                                                           minimalSpaceExists=true
                                                       }
                                                    if(minimalSpaceExists)
                                                    {
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
                                                        //Section window handling
                                                      
                                                        do{
                                                          //Check if the task WorkTime is bigger then the available space, or if we can'y use the whole freeSpace duration since the newTask startTime is from current hour which is bigger from the freeSpace startTime.
                                                            let actualFreeSpaceDuration = freeSpace.ending.subtract(newHour: newTask.startTime!)
                                                            
                                                            if(asstimatedWorkTime > freeSpace.duration || freeSpace.ending.subtract(newHour: newTask.startTime!) < freeSpace.duration && actualFreeSpaceDuration < asstimatedWorkTime)
                                                            {//Case we can't fit the whole task in the section window
                                                                
                                                              
                                                                
                                                                
                                                               // let remainingWorkSpace = freeSpace.duration
                                                                
                                                                print("P2: "+asstimatedWorkTime.hour.description+":"+asstimatedWorkTime.minutes.description)
                                                                //if the remanining WorkTime after therotically scheduling this task is bigger or equal to the minimalPartitionSize then schedule the current task
                                                                if(asstimatedWorkTime.subtract(newHour: actualFreeSpaceDuration) >= minimalPartitionSize)
                                                                {
                                                                    
                                                                    newTask.asstimatedWorkTime=actualFreeSpaceDuration
                                                                    
                                                                    
                                                                    
                                                                    remainingWorkTime = asstimatedWorkTime.subtract(newHour: newTask.asstimatedWorkTime)//The remaining work time to reSchedule
                                                                    
                                                               
                                                                }
                                                                else{
                                                                    
                                                                    var workTimeToSchedule=actualFreeSpaceDuration
                                                                    var tempRemainingWorkTime=asstimatedWorkTime.subtract(newHour: actualFreeSpaceDuration)
                                                                    let oneMinute=Hour(context: managedContext)
                                                                        oneMinute.hour=0
                                                                        oneMinute.minutes=1
                                                                    
                                                                   while(tempRemainingWorkTime < minimalPartitionSize)
                                                                   {
                                                                        workTimeToSchedule=workTimeToSchedule.subtract(newHour: oneMinute)
                                                                    tempRemainingWorkTime=tempRemainingWorkTime.add(hour: oneMinute)
                                                                    
                                                                    
                                                                   }
                                                                
                                                                    remainingWorkTime=tempRemainingWorkTime
                                                                    newTask.asstimatedWorkTime=workTimeToSchedule
                                                                    
                                                                }
                                                                
                                                                
                                                                newTask.endTime=newTask.startTime!.add(hour: newTask.asstimatedWorkTime)
                                                                
                                                                
                                                                    print("asstimatedWorkTime")
                                                                  print("asstimatedSorkTime"+String(newTask.asstimatedWorkTime.hour)+":"+String(newTask.asstimatedWorkTime.minutes))
                                                                isContinuesScheduling=true
                                                                print(internalId?.description ?? "0")
                                                                if(internalId == nil)
                                                                  {
                                                                    
                                                                    taskInternalId=UUID()
                                                                    newTask.internalId=taskInternalId
                                                                  }
                                                                  else{
                                                                      taskInternalId=internalId!
                                                                      newTask.internalId=internalId
                                                                  }
                                                                
                                                                
                                                            }
                                                            else{//Case we can schedule the whole task in the section window
                                                                newTask.endTime=newTask.startTime!.add(hour: asstimatedWorkTime)
                                                                
                                                                newTask.asstimatedWorkTime=asstimatedWorkTime
                                                                
                                                                  print("asstimatedSorkTime"+String(newTask.asstimatedWorkTime.hour)+":"+String(newTask.asstimatedWorkTime.minutes))
                                                                
                                                                isContinuesScheduling=false
                                                                if(internalId==nil)
                                                                {
                                                                    taskInternalId=UUID()
                                                                }
                                                                else{
                                                                    taskInternalId=internalId!
                                                                }
                                                                newTask.internalId=taskInternalId
                                                                
                                                            
                                                            }
                                                            
                                                        }
                                                        catch{//Case there are no tasks in that day, that's the only throw option
                                                            
                                                             let actualFreeSpaceDuration = freeSpace.ending.subtract(newHour: newTask.startTime!)
                                                                                                                 
                                                             if(asstimatedWorkTime > freeSpace.duration || freeSpace.ending.subtract(newHour: newTask.startTime!) < freeSpace.duration && actualFreeSpaceDuration < asstimatedWorkTime                                                                                                             )
                                                             {//Case we can't fit the whole task in the section window
                                                                 
                                                               
                                                                 
                                                                 
                                                                // let remainingWorkSpace = freeSpace.duration
                                                                 
                                                                 
                                                                 //if the remanining WorkTime after therotically scheduling this task is bigger or equal to the minimalPartitionSize then schedule the current task
                                                                 if(asstimatedWorkTime.subtract(newHour: actualFreeSpaceDuration) >= minimalPartitionSize)
                                                                 {
                                                                     
                                                                     newTask.asstimatedWorkTime=actualFreeSpaceDuration
                                                                     
                                                                     
                                                                     
                                                                     remainingWorkTime = asstimatedWorkTime.subtract(newHour: newTask.asstimatedWorkTime)//The remaining work time to reSchedule
                                                                     
                                                                
                                                                 }
                                                                 else{
                                                                     
                                                                     var workTimeToSchedule=actualFreeSpaceDuration
                                                                     var tempRemainingWorkTime=asstimatedWorkTime.subtract(newHour: actualFreeSpaceDuration)
                                                                     let oneMinute=Hour(context: managedContext)
                                                                         oneMinute.hour=0
                                                                         oneMinute.minutes=1
                                                                     
                                                                    while(tempRemainingWorkTime < minimalPartitionSize)
                                                                    {
                                                                         workTimeToSchedule=workTimeToSchedule.subtract(newHour: oneMinute)
                                                                     tempRemainingWorkTime=tempRemainingWorkTime.add(hour: oneMinute)
                                                                     
                                                                     
                                                                    }
                                                                 
                                                                     remainingWorkTime=tempRemainingWorkTime
                                                                     newTask.asstimatedWorkTime=workTimeToSchedule
                                                                     
                                                                 }
                                                                   
                                                                   newTask.endTime=newTask.startTime!.add(hour: newTask.asstimatedWorkTime)
                                                                  
                                                                
                                                                print("asstimatedSorkTime"+String(newTask.asstimatedWorkTime.hour)+":"+String(newTask.asstimatedWorkTime.minutes))
                                                                
                                                                   isContinuesScheduling=true
                                                                //print("internalId:"+internalId!.description)
                                                                  if(internalId == nil)
                                                                  {
                                                                    taskInternalId=UUID()
                                                                    newTask.internalId=taskInternalId
                                                                  }
                                                                  else{
                                                                      taskInternalId=internalId!
                                                                      newTask.internalId=internalId
                                                                  }
                                                                   
                                                                                                                       
                                                               }
                                                               else{//Case we can schedule the whole task in the section window
                                                                   newTask.endTime=newTask.startTime!.add(hour: asstimatedWorkTime)
                                                                   newTask.asstimatedWorkTime=asstimatedWorkTime
                                                                print("asstimatedSorkTime"+String(newTask.asstimatedWorkTime.hour)+":"+String(newTask.asstimatedWorkTime.minutes))
                                                                   isContinuesScheduling=false
                                                                   if(internalId==nil)
                                                                   {
                                                                       taskInternalId=UUID()
                                                                   }
                                                                   else{
                                                                       taskInternalId=internalId!
                                                                   }
                                                                    newTask.internalId=taskInternalId
                                                                  
                                                                    
                                                                
                                                               }
                                                            
                                                        }
                                                        
                                                    
                                                        newTask.completed=false
                                                        newTask.color=color
                                                        newTask.active=true
                                                        newTask.importance=importance
                                                        newTask.notes=notes
                                                        newTask.id=UUID()
                                                        newTask.isTaskBreakWindow=false
                                                        newTask.scheduleSection="hourAndAHalf"
                                                        newTask.associatedFreeSpaceId=freeSpace.associatedId
                                                        newTask.difficulty=difficulty
                                                        
                                                        createNotification(taskName: newTask.taskName, notes: newTask.notes! , internalId: newTask.internalId!, date: newTask.date, startTime: newTask.startTime!,notificationFactor:notificationFactor)
                                                        
                                                        handleLoad(date: newTask.date, duration: newTask.endTime!.subtract(newHour: newTask.startTime!))
                                                        
                                                        //Needs to send back this task at the end of execution
                                                        
                                                
                                                      /*  var newFreeSpaceStartTime = newTask.endTime!
                                                        let freeSpaceEndTime = freeSpace.ending
                                                        
                                                        var freeSpaceStarting:Hour
                                                                                                                                                           
                                                           if(isBreakSet)
                                                           {
                                                               newFreeSpaceStartTime=breakWindowEndTime
                                                               
                                                           }*/
                                                       
                                                        
                                                        
                                                        let freeSpaceDate = freeSpace.date
                                              
                                                        
                                                        if(!newTask.endTime!.isEqual(newHour: freeSpace.ending))
                                                        {//Handle deletion of old freeSpace and handling the new window of freeSpace
                                                            print("Reached!!")
                                                            print(String(newTask.endTime!.hour)+":"+String(newTask.endTime!.minutes))
                                                            print(String(freeSpace.ending.hour )+":"+String(freeSpace.ending.minutes))
                                                            let durationCalc=freeSpace.ending.subtract(newHour: newTask.endTime!)
                                                           
                                                            print("duration calc: ",durationCalc.hour,":",durationCalc.minutes)
                                                            //Create new FreeSpace excluding new task window
                                                            
                                                           
                                                            createFreeSpace(task:newTask,startTime:newTask.endTime! , endTime: freeSpace.ending, date: freeSpaceDate, duration: freeSpace.ending.subtract(newHour: newTask.endTime!),fullyOccupiedDay: false,orginalFreeSpaceId:freeSpace.associatedId!)
                                                            
                                                            
                                                              deleteFreeSpace(freeSpaceId: freeSpace.id)
                                                          
                                                        }
                                                        
                                                        else{//If the day is now fully occupied
                                                            //delete old FS object
                                                            deleteFreeSpace(freeSpaceId: freeSpace.id)
                                                            
                                                            let startOfDayHour = GetStartOfDay()
                                                         
                                                            
                                                            let endOfDayHour = GetEndOfDay()
                                                           
                                                            
                                                            let newDuration = Hour(context: managedContext)
                                                               newDuration.hour=0
                                                               newDuration.minutes=0
                                                            //Create new FS with fullyOccupied flag
                                                            _=createFreeSpace(startTime:startOfDayHour , endTime: endOfDayHour, date: freeSpaceDate, duration:newDuration,fullyOccupiedDay: true)
                                                        }
                                                        
                                                        if(isContinuesScheduling)
                                                        {
                                                            do{
                                                           
                                                                if(safetyCount==0)
                                                                {
                                                                    throw DatabaseError.taskCanNotBeScheduledInDue
                                                                }
                                                                try ContinuesScheduleHandler(taskName: taskName, importance: importance, asstimatedWorkTime: remainingWorkTime, dueDate: dueDate, notes: notes, color: color, internalId: taskInternalId,safetyCount:safetyCount)
                                                            }
                                                            catch{
                                                                throw DatabaseError.taskCanNotBeScheduledInDue
                                                            }
                                                        }
                                                        
                                                        return newTask
                                                    }
                                                }
                                            
                                            }
                                            
                                        }
                                    }
                                }
                                
                            }
                           /* else{//If the  re is no FreeSpace object for that day, create one
                                
                              
                                  
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
                      
                     
                                               
                        
                                              
                     
                        throw DatabaseError.taskCanNotBeScheduledInDue
                        //Shouldn't get here, if we do, return an empty task. Needs to check how to properly handle this.
                        return Task()
        //Needs to return task object to the calling precedure (probably from the Model, or ViewModel)
    }
    
    func ViewStandardHourConverter(hourVar:Hour) ->String
       {
            var viewStandardisedHour=""
           
           if(String(hourVar.hour).count==1)
           {
               viewStandardisedHour="0"+String(hourVar.hour)
           }
           else{
               viewStandardisedHour=String(hourVar.hour)
           }
           
           viewStandardisedHour=viewStandardisedHour+":"
        
           if(String(hourVar.minutes).count==1)
           {
                viewStandardisedHour=viewStandardisedHour+"0"+String(hourVar.minutes)
           }
           else{
                viewStandardisedHour=viewStandardisedHour+String(hourVar.minutes)
            }
           
        return viewStandardisedHour
           
   
       }
    
    func GetStartOfDay () -> Hour
     {
         let taskModel=TaskModel()
        
        return taskModel.GetStartOfDay()
     }
     
     func GetEndOfDay () -> Hour
     {
         
        let taskModel=TaskModel()
               
        return taskModel.GetEndOfDay()
        
     }
    
    
    func createNotification(taskName:String,notes:String,internalId:UUID,date:CustomDate,startTime:Hour,notificationFactor:Int)
    {
        
        if(notificationFactor != -1)//-1 represent no notification option.
        {
            let viewHourString=ViewStandardHourConverter(hourVar:startTime)
            
            let content = UNMutableNotificationContent()
            content.title = "Its Almost Time To Start Working On "+taskName+" !"
            content.subtitle = "You May Start At: "+viewHourString
            content.sound = UNNotificationSound.default

        
            
         
            
            let notificationAlert = startTime.subtract(minutesValue: notificationFactor)
            
            var dateComponents = DateComponents()
                dateComponents.year = date.year
                dateComponents.month = date.month
                dateComponents.day = date.day
                dateComponents.hour=notificationAlert.hour
                dateComponents.minute=notificationAlert.minutes
            
         
            
            let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponents, repeats: false)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: internalId.uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
        
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
    func DensityEnumConverter(phrase:String) -> scheduleDensity
      {
          
              switch phrase {
              case scheduleDensity.verySpacious.rawValue:
                   return scheduleDensity.verySpacious
                case scheduleDensity.spacious.rawValue:
                    return scheduleDensity.spacious
                case scheduleDensity.mediumDensity.rawValue:
                    return scheduleDensity.mediumDensity
                case scheduleDensity.dense.rawValue:
                    return scheduleDensity.dense
                case scheduleDensity.veryDense.rawValue:
                    return scheduleDensity.veryDense
                case scheduleDensity.extremelyDense.rawValue:
                    return scheduleDensity.extremelyDense
                case scheduleDensity.maximumCapacity.rawValue:
                    return scheduleDensity.maximumCapacity
                default:
                    return scheduleDensity.mediumDensity
              }
          
            return scheduleDensity.mediumDensity
      }
    
    func densityHandler(date:CustomDate,workTime:Hour,includePersonalTime:Bool) -> Bool
     {//Deactivated at this point !!!!!, see comment in var algorithm line, to activate cacncel commenting
        
        //Checks if a day is avilable in terms of ideal space regarding the scheduleDensity choise
        
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return true }
         
         //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Task")
                                                     
                                 
        fetchRequest.predicate = NSPredicate(format: "date.day = %@ AND date.month = %@ AND date.year = %@ AND isTaskBreakWindow = %@", argumentArray: [date.day,date.month,date.year,false])
        
        let algorithm=scheduleDensity.maximumCapacity//DensityEnumConverter(phrase: taskModel.getSettingsValues().scheduleDensity) // since the algorithms determining best results already, it's meaningless to upperbound a day density capicity, if the user doesn't want any more tasks he won't insert them the spreading of stress is already ideal.
        
         var scheduledDuration = workTime.hourInMinutes()
         var duration:Hour
     
        
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
            case .verySpacious:// Up to 1.5 hours of work per day
                if(scheduledDuration <= 90)
                {
                    return true
                }
                return false
            case .spacious:// Up to 2.5 hours of work per day
                if(scheduledDuration <= 150)
                 {
                     return true
                 }
                 return false
            case .mediumDensity:// Up to 3 hours of work per day
                if(scheduledDuration <= 180)
                 {
                     return true
                 }
                 return false
            case .dense:// Up to 4 hours of work per day
                   if(scheduledDuration <= 240)
                    {
                        return true
                    }
                    return false
            case .veryDense:// Up to 5 hours of work per day
                    if(scheduledDuration <= 300)
                     {
                         return true
                     }
                     return false
            case .extremelyDense:// Up to 7 hours of work per day
                if(scheduledDuration <= 420)
                  {
                      return true
                  }
                  return false
            case .maximumCapacity:// Unlimited hours of work per day
                     return true
            default:
                return true
            }
         
    
        
         
     }
    
   /* func breakConfirmation(suggestedStartHour:Hour,date:CustomDate,algorithm:scheduleDensity) -> Hour
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
       
        let sortedFreeSpaces=retriveAndSortFreeSpaces(dueDate:dateTime)
       
       var freeSpacesToDelete=[UUID]()
        var createdFreeSpaceId=UUID()
        
       var didCreateFreeSpace = false
        
       for index in 0...sortedFreeSpaces.count-1
       {
       
             print("General free space in the loop from "+String(sortedFreeSpaces[index].starting.hour)+":"+String(sortedFreeSpaces[index].starting.minutes)+" To "+String(sortedFreeSpaces[index].ending.hour)+":"+String(sortedFreeSpaces[index].ending.minutes))
        
            if(sortedFreeSpaces[index].id==createdFreeSpace)
           {
            
            
            if(index > 0 && sortedFreeSpaces[index].date==sortedFreeSpaces[index-1].date && sortedFreeSpaces[index].starting == sortedFreeSpaces[index-1].ending && sortedFreeSpaces[index].associatedId!==sortedFreeSpaces[index-1].associatedId!)//If it's indeed the same date and this are two sequntial free spaces, in which the second starts in the ending of the first right away
               {
                   didCreateFreeSpace=true
                
                   print(sortedFreeSpaces[index].ending)
                   print(sortedFreeSpaces[index-1].starting)
                    print("Found mergeble free space from"+String(sortedFreeSpaces[index-1].starting.hour)+":"+String(sortedFreeSpaces[index-1].starting.minutes)+" To "+String(sortedFreeSpaces[index-1].ending.hour)+":"+String(sortedFreeSpaces[index-1].ending.minutes))
                    
                   createdFreeSpaceId=createFreeSpace(startTime: sortedFreeSpaces[index-1].starting, endTime: sortedFreeSpaces[index].ending, date: sortedFreeSpaces[index].date, duration: sortedFreeSpaces[index].ending.subtract(newHour: sortedFreeSpaces[index-1].starting), fullyOccupiedDay: false)
                 print("Created merged free space from"+String(sortedFreeSpaces[index-1].starting.hour)+":"+String(sortedFreeSpaces[index-1].starting.minutes)+" To "+String(sortedFreeSpaces[index].ending.hour)+":"+String(sortedFreeSpaces[index].ending.minutes))
                    
                print("freeSpace to delete is: " + createdFreeSpace.description )
                print("freeSpace to delete is: " + sortedFreeSpaces[index-1].id.description )
                    freeSpacesToDelete.append(createdFreeSpace)
                    freeSpacesToDelete.append(sortedFreeSpaces[index-1].id)
                  
                
               }
                
            if(index+1 <= sortedFreeSpaces.count-1 && sortedFreeSpaces[index].date==sortedFreeSpaces[index+1].date && sortedFreeSpaces[index].ending == sortedFreeSpaces[index+1].starting && sortedFreeSpaces[index].associatedId!==sortedFreeSpaces[index+1].associatedId!)
               {
                   if(didCreateFreeSpace)
                   {
                    
                       print("Found mergeble free space from"+String(sortedFreeSpaces[index+1].starting.hour)+":"+String(sortedFreeSpaces[index+1].starting.minutes)+" To "+String(sortedFreeSpaces[index+1].ending.hour)+":"+String(sortedFreeSpaces[index+1].ending.minutes))
                        print("Free space will be merged with the latest freeSpace creted a second ago")
                        _=createFreeSpace(startTime: sortedFreeSpaces[index-1].starting, endTime: sortedFreeSpaces[index+1].ending, date: sortedFreeSpaces[index+1].date, duration: sortedFreeSpaces[index+1].ending.subtract(newHour: sortedFreeSpaces[index-1].starting), fullyOccupiedDay: false)
                       print("Created merged free space from"+String(sortedFreeSpaces[index-1].starting.hour)+":"+String(sortedFreeSpaces[index-1].starting.minutes)+" To "+String(sortedFreeSpaces[index+1].ending.hour)+":"+String(sortedFreeSpaces[index+1].ending.minutes))
                    
                        freeSpacesToDelete.append(createdFreeSpaceId)
                    
                        print("Will delete old free space from: "+String(sortedFreeSpaces[index].starting.hour)+":"+String(sortedFreeSpaces[index].starting.minutes)+" To "+String(sortedFreeSpaces[index].ending.hour)+":"+String(sortedFreeSpaces[index].ending.minutes))
                    print("freeSpace to delete is: " + sortedFreeSpaces[index].id.description )
                    
                        
                    
                        
                    }
                   else{
                    _=createFreeSpace(startTime: sortedFreeSpaces[index].starting, endTime: sortedFreeSpaces[index+1].ending, date: sortedFreeSpaces[index].date, duration: sortedFreeSpaces[index+1].ending.subtract(newHour: sortedFreeSpaces[index].starting), fullyOccupiedDay: false,orginalFreeSpaceAssociatedId:sortedFreeSpaces[index].associatedId!)
                    
                              print("Created merged free space from"+String(sortedFreeSpaces[index].starting.hour)+":"+String(sortedFreeSpaces[index].starting.minutes)+" To "+String(sortedFreeSpaces[index+1].ending.hour)+":"+String(sortedFreeSpaces[index+1].ending.minutes))
                    }
                
                        if(!freeSpacesToDelete.contains(createdFreeSpace))
                        {
                                freeSpacesToDelete.append(createdFreeSpace)
                              print("freeSpace to delete is: " + createdFreeSpace.description )
                        }
                
                        freeSpacesToDelete.append(sortedFreeSpaces[index+1].id)
                print("freeSpace to delete is: " + sortedFreeSpaces[index+1].id.description )
                    
                
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
        

        
        let dDate = CustomDate(context: managedContext)
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
           
        let dDate = CustomDate(context: managedContext)
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
                 
                 
                
        
                 /* retrivedFreeDays.sort {
                               ($0.date.year, $0.date.month, $0.date.day,$0.starting.hour) <
                                   ($1.date.year,$1.date.month,$1.date.day,$1.starting.hour)
                           }*/
              
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
        
         //Sort by this order preference: year, month, day
            suitableFreeDays.sort {
                ($0.date.year, $0.date.month, $0.date.day,$0.starting.hour,$0.starting.minutes) <
                    ($1.date.year,$1.date.month,$1.date.day,$1.starting.hour,$1.starting.minutes)
            }

           return suitableFreeDays
       }
       
    
    func scheduleFreeSpace (date:CustomDate)
    {
        var retrivedRestrictedSlots = [RestrictedSpace]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                 
         //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
  
        
        let startDayHour = GetStartOfDay()
                                                       
        let endDayHour = GetEndOfDay()
      
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
                 freeSpace.associatedId=UUID()
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
                               freeSpace.associatedId=UUID()
              
                        freeSpace.starting=freeSpaceInstance.starting
                         freeSpace.ending=restrictedSlot.startTime
                         freeSpace.duration=restrictedSlot.startTime.subtract(newHour: freeSpaceInstance.starting)
                         freeSpace.fullyOccupiedDay=false
                         
                         let secondaryFreeSpace=FreeTaskSpace(context: managedContext)
                         
                         secondaryFreeSpace.starting=restrictedSlot.endTime
                         secondaryFreeSpace.ending=freeSpaceInstance.ending
                 
                         secondaryFreeSpace.duration=freeSpaceInstance.ending.subtract(newHour: secondaryFreeSpace.starting)
                        // print(freeSpaceInstance.ending.subtract(newHour: secondaryFreeSpace.starting))
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
                           freeSpace.associatedId=UUID()
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
                           //print(endDayHour.subtract(newHour: freeSpace.starting))
                           //print(freeSpace.duration)
                           freeSpace.fullyOccupiedDay=false
                            
                            deleteFreeSpace(freeSpaceId: freeSpaceInstance.id)//Delete old free space since we made changes and created one or two free spaces instead
                                           
                        
                            
                         
                     }
                     else if (restrictedSlot.endTime == freeSpaceInstance.ending)
                     {
                           let freeSpace = FreeTaskSpace(context: managedContext)
                             freeSpace.date=date
                             freeSpace.id=UUID()
                             freeSpace.associatedId=UUID()
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
                    //print("here")
                }
                if(restrictedSlot.startTime > startDayHour && restrictedSlot.endTime < endDayHour)
                  {
                               
                    let freeSpace = FreeTaskSpace(context: managedContext)
                            freeSpace.date=date
                            freeSpace.id=UUID()
                            freeSpace.associatedId=UUID()
           
                      freeSpace.starting=startDayHour
                      freeSpace.ending=restrictedSlot.startTime
                      freeSpace.duration=restrictedSlot.startTime.subtract(newHour: startDayHour)
                      freeSpace.fullyOccupiedDay=false
                      
                      let secondaryFreeSpace=FreeTaskSpace(context: managedContext)
                      secondaryFreeSpace.associatedId=UUID()
                      secondaryFreeSpace.starting=restrictedSlot.endTime
                      secondaryFreeSpace.ending=endDayHour
                      secondaryFreeSpace.duration=endDayHour.subtract(newHour: secondaryFreeSpace.starting)
                      //print(endDayHour.subtract(newHour: secondaryFreeSpace.starting))
                      secondaryFreeSpace.date=date
                      secondaryFreeSpace.fullyOccupiedDay=false
                      secondaryFreeSpace.id=UUID()
                  }
                  else if(restrictedSlot.startTime == startDayHour && restrictedSlot.endTime == endDayHour)
                  {
                        let freeSpace = FreeTaskSpace(context: managedContext)
                        freeSpace.date=date
                        freeSpace.id=UUID()
                        freeSpace.associatedId=UUID()
                        freeSpace.starting=startDayHour
                        freeSpace.ending=endDayHour
                        freeSpace.duration=theZeroHour
                        freeSpace.fullyOccupiedDay=true
                          
                  }
                  else if(restrictedSlot.startTime == startDayHour)
                  {
                        let freeSpace = FreeTaskSpace(context: managedContext)
                        freeSpace.associatedId=UUID()
                        freeSpace.date=date
                        freeSpace.id=UUID()
                        freeSpace.starting=restrictedSlot.endTime
                        freeSpace.ending=endDayHour
                        freeSpace.duration=endDayHour.subtract(newHour: freeSpace.starting)
                        //print(endDayHour.subtract(newHour: freeSpace.starting))
                        //print(freeSpace.duration)
                        freeSpace.fullyOccupiedDay=false
                      
                  }
                  else if (restrictedSlot.endTime == endDayHour)
                  {
                        let freeSpace = FreeTaskSpace(context: managedContext)
                          freeSpace.date=date
                          freeSpace.id=UUID()
                          freeSpace.associatedId=UUID()
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
        
       if(!GetHourSection().isContinues)
        {
            SectionFreeSpace(date:date)
        }
        
    }
    
    func reSectionUsedFreeSpace()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let breakTime = GetHourSection().breakTime else {return}
        guard let totalSectionTime = GetHourSection().sectionWindow?.add(hour: breakTime) else {return}
          
        let taskModel=TaskModel()
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let currentDate=CustomDate(context: managedContext)
            currentDate.day=Date().day
            currentDate.month=Date().month
            currentDate.year=Date().year
        
        
        var allTasks=taskModel.retrieveAllTasks()
        
        allTasks.sort {
            ($0.date.year, $0.date.month, $0.date.day) <
                ($1.date.year,$1.date.month,$1.date.day)
        }
        
        if(allTasks.count>0)
        {
            let latestTask = allTasks[allTasks.count-1]

            
            var retrivedSpaces=[FreeTaskSpace]()
            var calendarSequance=[CustomDate]()
            
            print(latestTask.date.day.description+"/"+latestTask.date.month.description)
             do{
               calendarSequance = try createCalanderSequence(startDate: currentDate, endDate: latestTask.date)
            }
            catch{
                        print(error)
                    }
            
               do{
                   for date in calendarSequance
                   {
                
                        retrivedSpaces=try retrieveAllFreeSpaces(date: date)
                        for freeSpace in retrivedSpaces
                        {
                            if (freeSpace.duration >= totalSectionTime)
                            {
                                SectionFreeSpace(date: date)
                            }
                            
                        }
                    
                    }
               }
               catch{
                   print(error)
               }

        }
        
        
    }
    
    
    func SectionFreeSpace(freeSpaceToSection:FreeTaskSpace)
       {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           guard let breakTime = GetHourSection().breakTime else {return}
           guard let totalSectionTime = GetHourSection().sectionWindow?.add(hour: breakTime) else {return}
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
             
        let zeroHour=Hour(context: managedContext)
               zeroHour.hour=0
               zeroHour.minutes=0
           
         
           
      
           
        
           
           let spaceSection=GetHourSection()
          /* var breakTime:Hour=spaceSection.breakTime!
           var totalSectionTime=spaceSection.sectionWindow!.add(hour: breakTime)*/
           
         
               var remainingSpace=freeSpaceToSection.duration
               var currentStartingTime=freeSpaceToSection.starting
               let absoluteFreeSpaceEnding=freeSpaceToSection.ending
               var usedTimeEndBound=Hour(context: managedContext)
               let orginalFreeSpaceId=freeSpaceToSection.id
              
               while(remainingSpace.hour > 0 || remainingSpace.minutes > 0)
               {
            
                   
                    let freeSpace = FreeTaskSpace(context: managedContext)
                    
                    freeSpace.date=freeSpaceToSection.date
                     freeSpace.id=UUID()
                     freeSpace.associatedId=UUID()
                     freeSpace.starting=currentStartingTime
                     
                     if(currentStartingTime.add(hour: totalSectionTime) < absoluteFreeSpaceEnding)
                     {
                       
                       freeSpace.ending=currentStartingTime.add(hour: spaceSection.sectionWindow!)
                       
                       let breakWindow=Task(context: managedContext)
                           breakWindow.startTime=freeSpace.ending
                           breakWindow.endTime=breakWindow.startTime!.add(hour: spaceSection.breakTime!)
                           breakWindow.taskName=""
                           breakWindow.asstimatedWorkTime=spaceSection.breakTime!
                           breakWindow.completed=false
                           breakWindow.color="Green"
                           breakWindow.active=true
                           breakWindow.importance=""
                           breakWindow.notes=""
                           breakWindow.id=UUID()
                           breakWindow.isTaskBreakWindow=true
                           breakWindow.scheduleSection="hourAndAHalf"
                           breakWindow.date=freeSpaceToSection.date
                           breakWindow.dueDate=Date()
                           breakWindow.internalId=UUID()
                           breakWindow.difficulty="average"//formality for coredata, non relvent feed
                           
                           usedTimeEndBound=freeSpace.ending.add(hour: breakWindow.asstimatedWorkTime)
                   
                       
                     }
                     else if(currentStartingTime.add(hour: spaceSection.sectionWindow!) < absoluteFreeSpaceEnding){
                       
                       freeSpace.ending=currentStartingTime.add(hour: spaceSection.sectionWindow!)
                        usedTimeEndBound=freeSpace.ending
                     }
                     else{
                       freeSpace.ending=absoluteFreeSpaceEnding
                       usedTimeEndBound=freeSpace.ending
                     }
                   
                  
                   if(freeSpace.ending > freeSpace.starting)
                   {
                     freeSpace.duration=freeSpace.ending.subtract(newHour: freeSpace.starting)
                   }
                   else{
                       freeSpace.duration=zeroHour
                   }
                   
                     freeSpace.fullyOccupiedDay=false
                   
                   print("absoluteFreeSpaceEnding"+String(absoluteFreeSpaceEnding.hour)+":"+String(absoluteFreeSpaceEnding.minutes)+" usedTimeEndBound"+String(usedTimeEndBound.hour)+":"+String(usedTimeEndBound.minutes))
                   
                     remainingSpace=absoluteFreeSpaceEnding.subtract(newHour: usedTimeEndBound)
                     currentStartingTime=usedTimeEndBound
           
               }
             
               do {
                   
                      try managedContext.save()
                          print("Saved Task !.")
                  } catch let error as NSError {
                      print("Could not save. \(error), \(error.userInfo)")
                  }
               
               deleteFreeSpace(freeSpaceId: orginalFreeSpaceId)
           
           
       }
    func SectionFreeSpace(date:CustomDate)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let breakTime = GetHourSection().breakTime else {return}
        guard let totalSectionTime = GetHourSection().sectionWindow?.add(hour: breakTime) else {return}
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
          
        let zeroHour=Hour(context: managedContext)
            zeroHour.hour=0
            zeroHour.minutes=0
        
        var retrivedSpaces=[FreeTaskSpace]()
        
        do{
            retrivedSpaces=try retrieveAllFreeSpaces(date: date)
        }
        catch{
            print(error)
        }
        
     
        
        let spaceSection=GetHourSection()
       /* var breakTime:Hour=spaceSection.breakTime!
        var totalSectionTime=spaceSection.sectionWindow!.add(hour: breakTime)*/
        
        for retrivedSpace in retrivedSpaces
        {
            var remainingSpace=retrivedSpace.duration
            var currentStartingTime=retrivedSpace.starting
            let absoluteFreeSpaceEnding=retrivedSpace.ending
            var usedTimeEndBound=Hour(context: managedContext)
            let orginalFreeSpaceId=retrivedSpace.id
           
            while(remainingSpace.hour > 0 || remainingSpace.minutes > 0)
            {
         
                
                 let freeSpace = FreeTaskSpace(context: managedContext)
                 
                  freeSpace.date=date
                  freeSpace.id=UUID()
                  freeSpace.associatedId=UUID()
                  freeSpace.starting=currentStartingTime
                  
                  if(currentStartingTime.add(hour: totalSectionTime) < absoluteFreeSpaceEnding)
                  {
                    
                    freeSpace.ending=currentStartingTime.add(hour: spaceSection.sectionWindow!)
                    
                    let breakWindow=Task(context: managedContext)
                        breakWindow.startTime=freeSpace.ending
                        breakWindow.endTime=breakWindow.startTime!.add(hour: spaceSection.breakTime!)
                        breakWindow.taskName=""
                        breakWindow.asstimatedWorkTime=spaceSection.breakTime!
                        breakWindow.completed=false
                        breakWindow.color="Green"
                        breakWindow.active=true
                        breakWindow.importance=""
                        breakWindow.notes=""
                        breakWindow.id=UUID()
                        breakWindow.isTaskBreakWindow=true
                        breakWindow.scheduleSection="hourAndAHalf"
                        breakWindow.date=date
                        breakWindow.dueDate=Date()
                        breakWindow.internalId=UUID()
                        breakWindow.difficulty="average"//formality for coredata, non relvent feed
                        
                        usedTimeEndBound=freeSpace.ending.add(hour: breakWindow.asstimatedWorkTime)
                
                    
                  }
                  else if(currentStartingTime.add(hour: spaceSection.sectionWindow!) < absoluteFreeSpaceEnding){
                    
                    freeSpace.ending=currentStartingTime.add(hour: spaceSection.sectionWindow!)
                     usedTimeEndBound=freeSpace.ending
                  }
                  else{
                    freeSpace.ending=absoluteFreeSpaceEnding
                    usedTimeEndBound=freeSpace.ending
                  }
                
               
                if(freeSpace.ending > freeSpace.starting)
                {
                  freeSpace.duration=freeSpace.ending.subtract(newHour: freeSpace.starting)
                }
                else{
                    freeSpace.duration=zeroHour
                }
                
                  freeSpace.fullyOccupiedDay=false
                
                print("absoluteFreeSpaceEnding"+String(absoluteFreeSpaceEnding.hour)+":"+String(absoluteFreeSpaceEnding.minutes)+" usedTimeEndBound"+String(usedTimeEndBound.hour)+":"+String(usedTimeEndBound.minutes))
                
                  remainingSpace=absoluteFreeSpaceEnding.subtract(newHour: usedTimeEndBound)
                  currentStartingTime=usedTimeEndBound
        
            }
          
            do {
                
                   try managedContext.save()
                       print("Saved Task !.")
               } catch let error as NSError {
                   print("Could not save. \(error), \(error.userInfo)")
               }
            
            deleteFreeSpace(freeSpaceId: orginalFreeSpaceId)
        
        }
    }
 
    
    
  /*func retrieveAllSpaces() throws//We assume all appropriate days have been constructed beforehand
    {

        let dayOfToday = Date().day
        
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
                      
                    /*    if (results.count == 0)
                        {
                            print("It's 0 ")
                        }
                        
                        for result in results as! [NSManagedObject] {
                                print("Name: ")
                                print(result.value(forKey: "assignedTaskName") as! String)
                                print("startTime: ")
                            print(result.value(forKey: "startTime")!)
                        }*/
                        
                      
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
                         
                         /*  if (results.count == 0)
                           {
                               print("It's 0 ")
                           }*/
                           
                           for result in results as! [NSManagedObject] {
                              //  print("Id: ")
                                var id = result.value(forKey: "id") as! UUID
                               // print(id.uuidString)
                                var startingTime = result.value(forKey: "starting") as! Hour
                                //print("startTime.hour: ")
                               // print(startingTime.minutes)
                           }
                           
                         
                               // let retrievedObject = requiredTask[0] as! Task
                              
                          // print("Name:",retrievedObject.taskName as! String)
                           
                            
                         }
                           
                         catch
                         {
                             print(error)
                         }
               
               
               
               
               
           
           
           
               
       }*/
    
    func retrieveFreeSpace(date:CustomDate) throws -> FreeTaskSpace
    {


         //As we know that container is set up in the AppDelegates so we need to refer that container.
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return FreeTaskSpace()}
           
           //We need to create a context from this container
         let managedContext = appDelegate.persistentContainer.viewContext
           
  
 
         let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
        /* let predicate1 = NSPredicate(format: "month = %@",8)
         let predicate2 = NSPredicate(format: "month <%@",15)
         let predicate3 = NSPredicate(format: "year = %@",2020)
         let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2,predicate3])*/

        fetchRequest.predicate = NSPredicate(format: "date.year = %@ AND date.month = %@ AND date.day = %@", argumentArray: [date.year, date.month,date.day])
 
        var result=[Any]()
           do
           {
               result = try managedContext.fetch(fetchRequest)
            
            if (result.count > 1)
            {
                throw coreError.multipleFreeSpacesPerDate
            }
            
                return result[0] as! FreeTaskSpace
              
           }
             
           catch
           {
               print(error)
           }
     
     
               //Theroticlly it's impossible to get here, compilation syntax use only.
                return result[0] as! FreeTaskSpace
                 
             
             
             
                 
    }
    
    
    func retrieveAllFreeSpaces(date:CustomDate)  -> [FreeTaskSpace]
   {
        var allFreeSpaces=[FreeTaskSpace]()

        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [FreeTaskSpace]()}
          
          //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
          
 

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FreeTaskSpace")
       /* let predicate1 = NSPredicate(format: "month = %@",8)
        let predicate2 = NSPredicate(format: "month <%@",15)
        let predicate3 = NSPredicate(format: "year = %@",2020)
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2,predicate3])*/

       fetchRequest.predicate = NSPredicate(format: "date.year = %@ AND date.month = %@ AND date.day = %@", argumentArray: [date.year, date.month,date.day])

       var result=[Any]()
          do
          {
              result = try managedContext.fetch(fetchRequest)
           
                for data in result as! [FreeTaskSpace] {

                         allFreeSpaces.append(data)
    
                 }
           
           
             
          }
            
          catch
          {
              print(error)
          }
    
    
              //Theroticlly it's impossible to get here, compilation syntax use only.
               return allFreeSpaces
                
            
            
            
                
   }
    
   func createCalanderSequence(startDate:CustomDate,endDate:CustomDate) throws -> [CustomDate]
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
       do{
           for day in currentIndexDate.day...endDate.day
           {
               let newDate = CustomDate(context:managedContext)
                                           newDate.year=currentIndexDate.year
                                           newDate.month=currentIndexDate.month
                                           newDate.day=day
               
                 dateSequence.append(newDate)
                                                                              
           }
       }
       catch{
           throw   DateBoundsError.dueDateIsInPastTime
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
                print("didn't delete old free space no"+freeSpaceId.description)
               }
               
           }
           catch
           {
               print(error)
           }
       }
    
    func createFreeSpace(task:Task,startTime:Hour, endTime:Hour,date:CustomDate,duration:Hour,fullyOccupiedDay:Bool,orginalFreeSpaceId:UUID){
        
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
                freeSpace.associatedId=orginalFreeSpaceId
                
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
                freeSpace.associatedId=UUID()
        
            
        
              //Now we have set all the values. The next step is to save them inside the Core Data
              
              do {
                  try managedContext.save()
                      print("Saved Free Space !.")
              } catch let error as NSError {
                  print("Could not save. \(error), \(error.userInfo)")
              }
        
        return freeSpace.id
    }
    
    
    func createFreeSpace(startTime:Hour, endTime:Hour,date:CustomDate,duration:Hour,fullyOccupiedDay:Bool,orginalFreeSpaceAssociatedId:UUID) -> UUID{
           
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
                   freeSpace.associatedId=orginalFreeSpaceAssociatedId
           
               
           
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
    
    
    
    
    /*func createData(taskName:String,importance:String,asstimatedWorkTime:Int32,dueDate:Date,notes:String){
        
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
              
        
        
        
        
    }*/
   
        
        
        
        
        
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
    
    var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return gregorian.date(byAdding: .day, value: 0, to: sunday)!
    }

    var endOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        return gregorian.date(byAdding: .day, value: 6, to: sunday)!
    }
    
}


    
    
    
    

