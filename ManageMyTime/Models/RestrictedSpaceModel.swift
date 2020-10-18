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

                     do {
                              try managedContext.save()
                                  print("Saved RestrictedSpace.")
                          } catch let error as NSError {
                              print("Could not save. \(error), \(error.userInfo)")
                          }
                    
                }
             
           }
           else{
            throw RestrictedSpaceError.alreadyScheduled
        }
           
    }
    
    
    func DeleteRestrictedSpace(id:UUID)
   {
       
       //As we know that container is set up in the AppDelegates so we need to refer that container.
             guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
             
             //We need to create a context from this container
             let managedContext = appDelegate.persistentContainer.viewContext
             
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RestrictedSpace")
             fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
            
            
             
             do
             {
                 let requiredRestrictedSpace = try managedContext.fetch(fetchRequest)
                 
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
                 
             }
             catch
             {
                 print(error)
             }
             
            
            // coreManagment.mergeFreeSpaces(createdFreeSpace:freeSpaceId)
             
   }
       
    
    
}
