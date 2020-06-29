//
//  HelperFuncs.swift
//  ManageMyTime
//
//  Created by רן א on 29/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation


class HelperFuncs{
    

    func dateToString(date : Date) -> String
    {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
        return formatter1.string(from: date)
    }
    
   
      
      
      func initTask() -> Task{
        
         var task = Task()
        
          task.setValue("Test", forKey: "taskName")
          task.setValue("Test", forKey: "importance")
          task.setValue(Date(), forKey: "dueDate")
          task.setValue("Test", forKey: "notes")
          task.setValue(60, forKey: "asstimatedWorkTime")
        
        return task
      }
    
}
