//
//  TaskSchedule.swift
//  ManageMyTime
//
//  Created by רן א on 03/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import UIKit

struct TaskSchedule: Identifiable {
    
    var id : UUID
    var taskName : String
    var startDate : Date
    var startTime : Date
    var endTime : Date
    var day : dayOfTheWeek
    var scheduledDate : Date
    var duration : CGFloat
    var importance : String
    var active: Bool
    var completed: Bool
    var notes: String?
    var dueDate: Date
    



    init(id : UUID,taskName : String,startTime : Date,endTime : Date,day : dayOfTheWeek,date : Date
        ,duration : CGFloat,importance : String,active: Bool,completed: Bool,notes: String?,dueDate: Date,startDate:Date)
    {
        self.id=id
        self.taskName=taskName
        self.startTime=startTime
        self.endTime=endTime
        self.day=day
        self.scheduledDate=date
        self.duration=duration
        self.importance=importance
        self.active=active
        self.completed=completed
        self.notes=notes
        self.dueDate=dueDate
        self.startDate=startDate
    }

}


