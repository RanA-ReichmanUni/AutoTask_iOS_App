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
import UIKit

extension Hour {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hour> {
        return NSFetchRequest<Hour>(entityName: "Hour")
    }

    @NSManaged public var hour: Int
    @NSManaged public var minutes: Int

    
    func add(newHour:Hour)
    {
        /*guard newHour.hour>=0 && newHour.minutes>=0 else {
            return
        }*/
        
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
    
    func add(hour:Hour) -> Hour
    {
        
        
        /*guard hour.hour>=0 && hour.minutes>=0 else {
            return Hour()
        }*/
        
        var returnedMinutes = self.minutes
        var returnedHour = self.hour
        
        if(returnedMinutes+hour.minutes>=60)
        {
            returnedMinutes=returnedMinutes+hour.minutes-60
            returnedHour+=1
            
        }
    
        else{
            
            returnedMinutes=returnedMinutes+hour.minutes
        
        }
        
        returnedHour=returnedHour+hour.hour
   
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Hour() }

        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newHourlyTime = Hour(context: managedContext)
        
        newHourlyTime.hour=returnedHour
        newHourlyTime.minutes=returnedMinutes
        
        return newHourlyTime
    }
    
    func add(minutesValue:Int) -> Hour
       {
         
           var returnedMinutes = self.minutes
           var returnedHour = self.hour
           
           if(returnedMinutes+minutesValue>=60)
           {
               returnedMinutes=returnedMinutes+minutesValue-60
               returnedHour+=1
               
           }
       
           else{
               
               returnedMinutes=returnedMinutes+minutesValue
           
           }
           
           
      
           
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Hour() }

                let managedContext = appDelegate.persistentContainer.viewContext
           
           let newHourlyTime = Hour(context: managedContext)
           
           newHourlyTime.hour=returnedHour
           newHourlyTime.minutes=returnedMinutes
           
           return newHourlyTime
       }
    
    func subtract(newHour:Hour) -> Hour
    {
       // print(String(newHour.hour)+":"+String(newHour.minutes))
       // print(String(self.hour)+":"+String(self.minutes))
        guard newHour.hour>=0 && newHour.minutes>=0 else {
            return Hour()
        }
        
        guard self.hour > newHour.hour || (newHour.hour==self.hour && self.minutes>=newHour.minutes) else {
                  return Hour()
              }
              
        
        var returnedMinutes = self.minutes
        var returnedHour = self.hour
        
        if(returnedMinutes < newHour.minutes)
        {
            returnedMinutes=60-newHour.minutes+returnedMinutes
            returnedHour-=1
            
        }
    
        else{
            
            returnedMinutes=returnedMinutes-newHour.minutes
        
        }
        
        returnedHour=returnedHour-newHour.hour
        
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Hour() }

             let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let newHourlyTime = Hour(context: managedContext)
        
        newHourlyTime.hour=returnedHour
        newHourlyTime.minutes=returnedMinutes
        
        return newHourlyTime
    }
    
    func subtract(minutesValue:Int) -> Hour
    {
        
        
        var returnedMinutes = self.minutes
        var returnedHour = self.hour
        if(returnedHour == 0 && returnedMinutes < minutesValue)
        {
            returnedMinutes=0
            returnedHour=0
        }
        else if(returnedMinutes < minutesValue)
        {
            returnedMinutes=60-minutesValue+returnedMinutes
            returnedHour-=1
            
        }
    
        else{
            
            returnedMinutes=returnedMinutes-minutesValue
        
        }
        
        
       
        
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return Hour() }

             let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let newHourlyTime = Hour(context: managedContext)
        
        newHourlyTime.hour=returnedHour
        newHourlyTime.minutes=returnedMinutes
        
        return newHourlyTime
    }
    
    func hourInMinutes() -> Int
    {
        
        return (self.hour*60+self.minutes)
  
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
    
    func isEqual(newHour:Hour) -> Bool
      {
      
        if(self.hour == newHour.hour && self.minutes == newHour.minutes )
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
    
    static func == (left: Hour, right: Hour) -> Bool { // 1
       
        if(left.hour==right.hour && left.minutes==right.minutes)
        {
            return true
        }
        return false
    }
    
    static func != (left: Hour, right: Hour) -> Bool { // 1
          
           if(left == right)
           {
               return false
           }
           return true
       }
    
    static func <= (left: Hour, right: Hour) -> Bool { // 1
       
        if(left < right || left == right)
        {
            return true
        }
        return false
    }
    
    static func > (left: Hour, right: Hour) -> Bool { // 1
       
        if(left.hour>right.hour || (left.hour == right.hour && left.minutes>right.minutes))
        {
            return true
        }
        return false
    }
    
    static func >= (left: Hour, right: Hour) -> Bool { // 1
       
        if(left > right || left == right)
        {
            return true
        }
        return false
    }

}
