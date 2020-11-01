//
//  RestrictedSpaceModel.swift
//  ManageMyTime
//
//  Created by רן א on 19/08/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

enum RestrictedSpaceError: Error {
        case alreadyScheduled
      

    }

class RestrictedSpaceModel : UIViewController
{

    func DayStringToNumConverter(dayOfTheWeek:String) -> Int
       {
           switch dayOfTheWeek.lowercased() {
           case "sunday":
               return 0
           case "monday":
               return 1
           case "tuesday":
               return 2
           case "wednesday":
               return 3
           case "thursday":
               return 4
           case "friday":
               return 5
           case "saturday":
               return 6
           default:
               return 0
           }
           
       
           
       }
    
    func getAllRestrictedSpace() -> [RestrictedSpace]
    {
        
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [RestrictedSpace]()}
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
        
        
        
           let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestrictedSpace")
                                                 
                             
          
           var restrictedSpace = [RestrictedSpace]()
               
             do
             {
                 let results = try managedContext.fetch(fetchRequest)
                 
           
                     
                     
                   for result in results as! [NSManagedObject] {

                         let spaceObj = result as! RestrictedSpace
                     
                         restrictedSpace.append(spaceObj)
                }
                
             }
             catch
             {
                 print(error)
             }
            
        
            restrictedSpace.sort{
            (DayStringToNumConverter(dayOfTheWeek:$0.dayOfTheWeek),$0.startTime.hour, $0.startTime.minutes) <
                                   (DayStringToNumConverter(dayOfTheWeek:$1.dayOfTheWeek),$1.startTime.hour, $1.startTime.minutes)
                            }
            
    
            return restrictedSpace
        
        
        
    }
    
    func getRestrictedSpaceColor (restrictedSpace:RestrictedSpace) -> Color
       {
           if(restrictedSpace.color.hasPrefix("#"))
           {
               return Color(hex:restrictedSpace.color)
           }
           
           switch restrictedSpace.color.lowercased() {
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
    func CheckEmptyRestrictedAndFreeSpace(date:CustomDate) -> Bool
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
            
                var isEmptyFreeSpace=false
                var isEmptyRestrictedSpace=false
        
      //
             do {
                 
                 let results = try managedContext.fetch(fetchRequest)
                  
                  
                  if(results.isEmpty)
                  {
                      isEmptyFreeSpace=true
                  }
                  else{
                      isEmptyFreeSpace=false
                  }
              
             } catch {
                 
                 print("Failed")
             }
         
        
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestrictedSpace")
                        fetch.predicate = NSPredicate(format: "dayOfTheWeek = %@",argumentArray: [date.dayOfWeek()])
                                     
                  
                  
                       
                     do
                     {
                         let results = try managedContext.fetch(fetch)
                         
                   
                         
                          if(results.isEmpty)
                          {
                              isEmptyRestrictedSpace=true
                          }
                          else{
                              isEmptyRestrictedSpace=false
                          }
                        
                        
                     }
                     catch
                     {
                         print(error)
                     }
        
            if(isEmptyFreeSpace && isEmptyRestrictedSpace)
            {
                return true
            }
       
           return false
          
          
      }
    
    func getAllRestrictedSpacesByDate(date:CustomDate) -> [RestrictedSpace]
      {
          
              guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [RestrictedSpace]()}
             
             //We need to create a context from this container
             let managedContext = appDelegate.persistentContainer.viewContext
          
                
          
             let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestrictedSpace")
                  fetchRequest.predicate = NSPredicate(format: "dayOfTheWeek = %@",argumentArray: [date.dayOfWeek()])
                               
            
             var restrictedSpace = [RestrictedSpace]()
                 
               do
               {
                   let results = try managedContext.fetch(fetchRequest)
                   
             
                       
                       
                     for result in results as! [NSManagedObject] {

                           let spaceObj = result as! RestrictedSpace
                       
                           restrictedSpace.append(spaceObj)
                  }
                  
               }
               catch
               {
                   print(error)
               }
                 
              restrictedSpace.sort {
                               ($0.startTime) <
                                   ($1.endTime)
              }
      
              return restrictedSpace
          
          
          
      }
    
    func CreateRestrictedSpace(name:String,color:String,startTime: Hour,endTime: Hour,daysOfTheWeek: [String],difficulty:String) throws
       {
        let helper=HelperFuncs()
        let taskModel=TaskModel()
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           
          
           let managedContext = appDelegate.persistentContainer.viewContext
           
           
           let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestrictedSpace")
           
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
           
           for day in daysOfTheWeek
           {
            
            if(allSpacesAtDay.contains(where: {day.lowercased() == $0.dayOfTheWeek.lowercased() && (startTime >= $0.startTime && endTime <= $0.endTime || startTime < $0.startTime && endTime > $0.startTime || startTime < $0.endTime && endTime >= $0.endTime)  }))
                   {
                    
                        alreadyScheduled=true
                    
                   }
      
           }
           
           if(!alreadyScheduled)
           {
            
            
            let allTasks = taskModel.retrieveAllTasks()
            var restrictedSpacesIds=[UUID]()
            var tasksToDelete=[Task]()
            var datesToRescheduleFreeSpaces=[CustomDate]()
            
              for day in daysOfTheWeek
              {
                if(allTasks.contains(where: {$0.date.dayOfWeek().lowercased()==day.lowercased() && taskModel.CheckHourContradiction(objectStartTime: $0.startTime!, objectEndTime: $0.endTime!, secondObjectStartTime: startTime, secondObjectEndTime: endTime)}))
                    {
                        
                        let matchingTasks=(allTasks.all(where: {$0.date.dayOfWeek().lowercased()==day.lowercased() && taskModel.CheckHourContradiction(objectStartTime: $0.startTime!, objectEndTime: $0.endTime!, secondObjectStartTime: startTime, secondObjectEndTime: endTime)}))
                        
                        
                        for task in matchingTasks
                        {
                            if (!datesToRescheduleFreeSpaces.contains(task.date))
                            {
                                datesToRescheduleFreeSpaces.append(task.date)
                            }
                            print(helper.dateToString(date: task.date))
                            print(helper.hourToString(hour:task.startTime!))
                            print(helper.hourToString(hour: task.endTime!))
                            
                        }
                        
                        tasksToDelete.append(contentsOf:matchingTasks )
 
                    }
              }
                for day in daysOfTheWeek
                {
                    let restrictedSpace = RestrictedSpace(context: managedContext)
                                 
                     restrictedSpace.startTime=startTime
                     restrictedSpace.endTime=endTime
                     restrictedSpace.dayOfTheWeek=day
                     restrictedSpace.id=UUID()
                     restrictedSpace.difficulty=difficulty
                     restrictedSpace.name=name
                     restrictedSpace.color=color
                   //  coreManagment.createDayFreeSpace(restrictedStartTime: startTime, restrictedEndTime: endTime, dayOfTheWeek: dayOfTheWeek)
                    
                    
                    restrictedSpacesIds.append(restrictedSpace.id)
                    
                     do {
                              try managedContext.save()
                                  print("Saved RestrictedSpace.")
                          } catch let error as NSError {
                              print("Could not save. \(error), \(error.userInfo)")
                          }
                    
                //Bound all relevent freeSpaces to the new restrictedSpace
                BoundFreeSpacesToRestrictedSpaces(restrictedSpace:restrictedSpace)
                    
                }
            
            
                
            
            
            do{
                if(!tasksToDelete.isEmpty)
                {
                    try RescheduleTasks(tasksToDelete: tasksToDelete, restrictedSpacesIds: restrictedSpacesIds,datesToRescheduleFreeSpaces: datesToRescheduleFreeSpaces)
                    
                }
            }
            catch DatabaseError.newRestrictedSpaceContradictionCantRescheduleTasks{
                
                //Insert restricted spaces that was deleted in order to schedule the previous dates again
                for day in daysOfTheWeek
                {
                    let restrictedSpace = RestrictedSpace(context: managedContext)
                                 
                     restrictedSpace.startTime=startTime
                     restrictedSpace.endTime=endTime
                     restrictedSpace.dayOfTheWeek=day
                     restrictedSpace.id=UUID()
                     restrictedSpace.difficulty=difficulty
                     restrictedSpace.name=name
                     restrictedSpace.color=color
                   //  coreManagment.createDayFreeSpace(restrictedStartTime: startTime, restrictedEndTime: endTime, dayOfTheWeek: dayOfTheWeek)
                    
                    restrictedSpacesIds.append(restrictedSpace.id)
                    
                     do {
                              try managedContext.save()
                                  print("Saved RestrictedSpace.")
                          } catch let error as NSError {
                              print("Could not save. \(error), \(error.userInfo)")
                          }
                    
               
           
                }
                
                throw DatabaseError.newRestrictedSpaceContradictionCantRescheduleTasks
            }
            
         
            
            
             
           }
           else{
            throw RestrictedSpaceError.alreadyScheduled
        }
           
    }
    
    func BoundFreeSpacesToRestrictedSpaces(restrictedSpace:RestrictedSpace)
    {//Handles bounding(deletion or change in length) of exsiting free spaces according to the new restrictedSpace set at a date
        
        let helper=HelperFuncs()
        
         let coreManagment=Core()
        
            //As we know that container is set up in the AppDelegates so we need to refer that container.
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           
           //We need to create a context from this container
           let managedContext = appDelegate.persistentContainer.viewContext
        
        let currentDate=CustomDate(context: managedContext)
                           currentDate.day=Date().day
                           currentDate.month=Date().month
                           currentDate.year=Date().year
                      
        
        
        //Create freeSpace to days (from current day) that restrictedSpace effected until now
                           
           let existingFreeSpaces = coreManagment.retriveAndSortFreeSpaces(startDate: currentDate)
           
            let freeSpacesToBound =  existingFreeSpaces.all(where: {$0.date.dayOfWeek().lowercased()==restrictedSpace.dayOfTheWeek.lowercased()})
           
           for freeSpaceToBound in freeSpacesToBound
           {
            print("at: "+helper.dateToString(date: freeSpaceToBound.date))
            print("Starts at: "+helper.hourToString(hour: freeSpaceToBound.starting))
            print("Ends at: "+helper.hourToString(hour: freeSpaceToBound.ending))
              
            coreManagment.ReScheduleFreeSpacesBoundByRestrictedSpaces(date: freeSpaceToBound.date)
               //coreManagment.SectionSingleFreeSpace(id:freeSpaceId)
           }
        
    }
    func RescheduleTasks(tasksToDelete:[Task],restrictedSpacesIds:[UUID],datesToRescheduleFreeSpaces:[CustomDate]) throws{
        
        var newScheduledTasksIds=[UUID]()
        let managmentCore=Core()
        let taskModel=TaskModel()
       // let allTasks = taskModel.retrieveAllTasks()
        var tasksToReschedule=[TempTaskObject]()
        
         for taskToDelete in tasksToDelete
         {
           
            tasksToReschedule.append(TempTaskObject(active: taskToDelete.active, color: taskToDelete.color!, completed: taskToDelete.completed, dueDate: taskToDelete.dueDate, id: taskToDelete.id, importance: taskToDelete.importance!, isTaskBreakWindow: taskToDelete.isTaskBreakWindow, notes: taskToDelete.notes!, taskName: taskToDelete.taskName, internalId: taskToDelete.internalId!, asstimatedWorkTime: taskToDelete.asstimatedWorkTime, date: taskToDelete.date, endTime: taskToDelete.endTime!, startTime: taskToDelete.startTime!, scheduleSection: taskToDelete.scheduleSection, associatedFreeSpaceId: taskToDelete.associatedFreeSpaceId!, difficulty: taskToDelete.difficulty))

         }
         
         
        
       /* for date in datesToRescheduleFreeSpaces
        {
            
            managmentCore.ScheduleFreeSpacesWithNoSection(date: date)
        }*/
         
       
        
                 
       
                 
             let allTasks = taskModel.retrieveAllTasks()
             
             for taskToReschedule in tasksToReschedule{
                 
                
                    do{
                        let taskId=try taskModel.CreateDataAndReturn(taskName: taskToReschedule.taskName, importance: taskToReschedule.importance, asstimatedWorkTime: taskToReschedule.asstimatedWorkTime, dueDate: taskToReschedule.dueDate, notes: taskToReschedule.notes,color:taskModel.getTaskColor(color: taskToReschedule.color),difficulty:taskToReschedule.difficulty,internalId:taskToReschedule.internalId)
                         newScheduledTasksIds.append(taskId)
                    }
                    catch DatabaseError.taskCanNotBeScheduledInDue{
                        //Get rid of some tasks that was rescheduled
                          for id in newScheduledTasksIds
                          {
                              taskModel.deleteTask(taskId: id)
                          }
                        
                          for id in restrictedSpacesIds{
                                   
                                  
                               DeleteRestrictedSpace(id: id)
                              
                              
                           }//Deletes All Previous Shceduled Restricted Spaces
                        
                        throw DatabaseError.newRestrictedSpaceContradictionCantRescheduleTasks
                    }
                   
                 
                 
             }

      
            //If all did go well, delete the orginal tasks
            for taskToDelete in tasksToDelete
            {
                
                taskModel.SingularTaskDelete(taskId: taskToDelete.id)
                
            }
                
             
         
        
    }
    
    func DeleteRestrictedSpace(id:UUID)
   {
      
       let coreManagment=Core()
       //As we know that container is set up in the AppDelegates so we need to refer that container.
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
             
             //We need to create a context from this container
             let managedContext = appDelegate.persistentContainer.viewContext
             
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RestrictedSpace")
             fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
    
             let currentDate=CustomDate(context: managedContext)
                currentDate.day=Date().day
                currentDate.month=Date().month
                currentDate.year=Date().year
    
                var restrictedSpaceStartTime=Hour(context: managedContext)
                    restrictedSpaceStartTime.hour=0
                    restrictedSpaceStartTime.minutes=0
                var restrictesSpaceEndTime=Hour(context: managedContext)
                    restrictesSpaceEndTime.hour=0
                    restrictesSpaceEndTime.minutes=0
            var restrictedSpaceDay=""
             
             do
             {
                 let requiredRestrictedSpace = try managedContext.fetch(fetchRequest)
               
                 let restrictedSpace = requiredRestrictedSpace[0] as! RestrictedSpace
                    restrictedSpaceStartTime=restrictedSpace.startTime
                    restrictesSpaceEndTime=restrictedSpace.endTime
                    
                 restrictedSpaceDay=restrictedSpace.dayOfTheWeek
                
                  let objectToDelete = requiredRestrictedSpace[0] as! NSManagedObject
                    managedContext.delete(objectToDelete)
                    do{
                        try managedContext.save()
         
                        print("Deleted !.")
                        
                           //Create freeSpace to days (from current day) that restrictedSpace effected until now
                                        
                        let existingFreeSpaces = coreManagment.retriveAndSortFreeSpaces(startDate: currentDate)
                        
                          print(existingFreeSpaces[0].date.description)
                          print(existingFreeSpaces[0].date.dayOfWeek().lowercased())
                          print(restrictedSpaceDay.lowercased())
                      
                        let existingFreeSpacesInDates =  existingFreeSpaces.all(where: {$0.date.dayOfWeek().lowercased()==restrictedSpaceDay.lowercased()})
                        
                        var nonDuplicateDates=[CustomDate]()
                      
                        for existedFreeSpace in existingFreeSpacesInDates
                        {
                          
                          if (!nonDuplicateDates.contains(existedFreeSpace.date))
                          {
                              nonDuplicateDates.append(existedFreeSpace.date)
                          }
                      }
                      
                      for date in nonDuplicateDates
                      {
        
                            let freeSpaceId=coreManagment.createFreeSpace(startTime: restrictedSpaceStartTime, endTime: restrictesSpaceEndTime, date: date, duration: restrictesSpaceEndTime.subtract(newHour: restrictedSpaceStartTime), fullyOccupiedDay: false)
                            
                            coreManagment.mergeFreeSpaces(createdFreeSpace:freeSpaceId)
                            
                            coreManagment.SectionSingleFreeSpace(id:freeSpaceId)//Needs to check if it's working
                        }
                       
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
             
            
            // coreManagment.mergeFreeSpaces(createdFreeSpace:freeSpaceId)
             
   }
    
    
    func DeleteRestrictedSpaceAndFillBack(id:UUID)
      {
        let coreManagment=Core()
          //As we know that container is set up in the AppDelegates so we need to refer that container.
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                
                //We need to create a context from this container
                let managedContext = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RestrictedSpace")
                fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
               let currentDate=CustomDate(context: managedContext)
                    currentDate.day=Date().day
                    currentDate.month=Date().month
                    currentDate.year=Date().year
               
                
                do
                {
                    let requiredRestrictedSpace = try managedContext.fetch(fetchRequest)
                    let restrictedSpace = requiredRestrictedSpace[0] as! RestrictedSpace
                    
                    
                     let objectToDelete = requiredRestrictedSpace[0] as! NSManagedObject
                       managedContext.delete(objectToDelete)
                       do{
                           try managedContext.save()
            
                           print("Deleted !.")
                          
                       }
                       catch
                       {
                           print(error)
                       }
                    
                    //Create freeSpace to days (from current day) that restrictedSpace effected until now
                    
                    let existingFreeSpaces = coreManagment.retriveAndSortFreeSpaces(startDate: currentDate)
                    
                    let daysToCreateFreeSpaceTo =  existingFreeSpaces.all(where: {$0.date.dayOfWeek().lowercased()==restrictedSpace.dayOfTheWeek.lowercased()})
                    
                    for dayToCreateFreeSpaceTo in daysToCreateFreeSpaceTo
                    {
                        let freeSpaceId=coreManagment.createFreeSpace(startTime: restrictedSpace.startTime, endTime: restrictedSpace.endTime, date: dayToCreateFreeSpaceTo.date, duration: restrictedSpace.endTime.subtract(newHour: restrictedSpace.startTime), fullyOccupiedDay: false)
                        
                        coreManagment.mergeFreeSpaces(createdFreeSpace:freeSpaceId)
                        
                        //coreManagment.SectionSingleFreeSpace(id:freeSpaceId)
                    }
                    
                }
                catch
                {
                    print(error)
                }
                
               
               // coreManagment.mergeFreeSpaces(createdFreeSpace:freeSpaceId)
                
      }
       
    
    
}
