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

enum RestrictedSpaceError: Error {
        case alreadyScheduled
      

    }

class RestrictedSpaceModel : UIViewController
{

    
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
               
            restrictedSpace.sort {
                             ($0.startTime) <
                                 ($1.endTime)
            }
    
            return restrictedSpace
        
        
        
    }
    
    
    func CreateRestrictedSpace(startTime: Hour,endTime: Hour,dayOfTheWeek: String) throws
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
               
             //  coreManagment.createDayFreeSpace(restrictedStartTime: startTime, restrictedEndTime: endTime, dayOfTheWeek: dayOfTheWeek)

               do {
                        try managedContext.save()
                            print("Saved RestrictedSpace.")
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
           }
           else{
            throw RestrictedSpaceError.alreadyScheduled
        }
           
       }
    
    
    
    
}
