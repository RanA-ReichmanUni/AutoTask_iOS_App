//
//  TasksPerDay.swift
//  ManageMyTime
//
//  Created by רן א on 15/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation


struct TasksPerHourPerDay:Identifiable{
    
    var id:UUID
    var tasks : [TaskPerHour]
    var isEmptySlot:Bool

    init(isEmptySlot:Bool,tasks:[TaskPerHour])
    {
        id=UUID()

        self.tasks=tasks
        self.isEmptySlot=isEmptySlot
    }
 
}


