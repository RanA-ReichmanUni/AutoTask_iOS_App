//
//  CustomDate+CoreDataProperties.swift
//  ManageMyTime
//
//  Created by רן א on 12/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//
//

import Foundation
import CoreData


extension CustomDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomDate> {
        return NSFetchRequest<CustomDate>(entityName: "CustomDate")
    }

    @NSManaged public var day: Int
    @NSManaged public var month: Int
    @NSManaged public var year: Int
    
    
  /*  var dateObj:DateComponents{
        
       var dateComponents=DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return dateComponents
        
    }*/
    
    var startOfMonth: Date {

        var dateComponents=DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: Calendar.current.date(from: dateComponents) ?? Date())

        return  calendar.date(from: components)!
    }
    
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    func dayOfWeek() -> String {
        var dateComponents = DateComponents()
                   dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day

        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let dateTime = userCalendar.date(from: dateComponents)
        
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           return dateFormatter.string(from: dateTime!).capitalized
          
       }//Get value by : "Date().dayOfWeek()!"
    
    func isEqual(year : Int,month : Int,day : Int) -> Bool
     {
         if(self.year==year && self.month==month  && self.day==day)
         {
             return true
         }
         return false
     }
    
    
    func isEqual(date:CustomDate) -> Bool
      {
        if(self.year==date.year && self.month==date.month  && self.day==date.day)
          {
              return true
          }
          return false
      }
    
    static func > (left: CustomDate, right: CustomDate) -> Bool { // 1
         
        if(left.year > right.year || (left.year == right.year && left.month > right.month) || (left.year == right.year && left.month == right.month && left.day > right.day) )
          {
              return true
          }
          return false
      }
     
     
    
    
}
