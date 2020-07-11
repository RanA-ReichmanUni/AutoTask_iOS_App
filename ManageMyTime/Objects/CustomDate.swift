//
//  CustomDate.swift
//  ManageMyTime
//
//  Created by רן א on 09/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct CustomDate {

    
    var year : Int{
         didSet{//When setting the property, do:
          dateComponents.year = year
          let userCalendar = Calendar.current
          dateObj = userCalendar.date(from: dateComponents) ?? Date()
        }
       
    }
    var month : Int{
         didSet{//When setting the property, do:
          dateComponents.month = month
          let userCalendar = Calendar.current
          dateObj = userCalendar.date(from: dateComponents) ?? Date()
        }

    }
    var day : Int{
         didSet{//When setting the property, do:
          dateComponents.day = day
          let userCalendar = Calendar.current
          dateObj = userCalendar.date(from: dateComponents) ?? Date()
        }
 
    }
 
    var dateObj:Date
    
    var dateComponents : DateComponents
    
    
    
    init(year : Int,month : Int,day : Int)
    {
        
        self.dateComponents=DateComponents()
                   dateComponents.year = year
                   dateComponents.month = month
                   dateComponents.day = day
     
        let userCalendar = Calendar.current
        self.dateObj = userCalendar.date(from: dateComponents) ?? Date()
        self.day=day
        self.month=month
        self.year=year
        
       
           

      
        }
    func isEqual(year : Int,month : Int,day : Int) -> Bool
    {
        if(self.year==year && self.month==month  && self.day==day)
        {
            return true
        }
        return false
    }
    
    
        
        var startOfMonth: Date {

              let calendar = Calendar(identifier: .gregorian)
              let components = calendar.dateComponents([.year, .month], from: dateObj)

              return  calendar.date(from: components)!
          }
        
        var endOfMonth: Date {
              var components = DateComponents()
              components.month = 1
              components.second = -1
              return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
          }
    
}
