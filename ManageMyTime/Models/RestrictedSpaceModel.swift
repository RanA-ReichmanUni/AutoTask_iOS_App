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
    
    
    
    
}
