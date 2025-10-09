//
//  HourlyTask.swift
//  ManageMyTime
//
//  Created by רן א on 04/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct HourlyTask: Identifiable {
    
    var id : UUID
    var hour : String
    var scheduledTasks : [TaskSchedule]
    var fullyOccupied : Bool
    
}
