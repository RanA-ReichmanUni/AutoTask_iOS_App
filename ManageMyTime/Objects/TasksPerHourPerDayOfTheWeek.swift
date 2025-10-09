//
//  TasksByHour.swift
//  ManageMyTime
//
//  Created by רן א on 14/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import UIKit

struct TasksPerHourPerDayOfTheWeek:Identifiable{
    

    var id:UUID
    var hour : Int
    var tasks : [TasksPerHourPerDay]
   
    
    init(hour:Int,tasks:[TasksPerHourPerDay])
    {
        id=UUID()
        self.hour=hour
        self.tasks=tasks
  

    }
 

}
