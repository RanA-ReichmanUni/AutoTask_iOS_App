//
//  Hour+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 07/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension Hour {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hour> {
        return NSFetchRequest<Hour>(entityName: "Hour")
    }

    @NSManaged public var hour: Int
    @NSManaged public var minutes: Int

    
    func add(newHour:Hour)
    {
        guard newHour.hour>=0 && newHour.minutes>=0 else {
            return
        }
        
        if(self.minutes+newHour.minutes>60)
        {
            self.minutes=self.minutes+newHour.minutes-60
            self.hour+=1
            
        }
    
        else{
            
            self.minutes=self.minutes+newHour.minutes
        
        }
        
        self.hour=self.hour+newHour.hour
        
    }
    
    
    func isBigger(newHour:Hour) -> Bool
    {
    
        if(self.hour > newHour.hour || (self.hour == newHour.hour && self.minutes > newHour.minutes) )
        {
           return true
        }
  
        return false
      
    }
    
      func isBiggerOrEqual(newHour:Hour) -> Bool
      {
      
          if(self.hour > newHour.hour || (self.hour == newHour.hour && self.minutes > newHour.minutes) )//Self is bigger
          {
             return true
          }
        
        if(self.hour == newHour.hour && self.minutes==newHour.minutes)//Equal
        {
             return true
        }
               
    
          return false
        
      }
    
    static func < (left: Hour, right: Hour) -> Bool { // 1
       
        if(left.hour<right.hour || (left.hour == right.hour && left.minutes<right.minutes))
        {
            return true
        }
        return false
    }

}
