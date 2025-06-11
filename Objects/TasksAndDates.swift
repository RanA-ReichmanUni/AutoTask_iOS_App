//
//  TasksAndDates.swift
//  ManageMyTime
//
//  Created by רן א on 21/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//


import Foundation


struct TasksAndDates:Identifiable{
    
    var id:UUID
    var tasks : [Task]
    var date:CustomDate
    
    init(date:CustomDate,tasks:[Task])
    {
        id=UUID()

        self.tasks=tasks
        self.date=date
    }
 
}
