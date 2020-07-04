//
//  TaskSchedule.swift
//  ManageMyTime
//
//  Created by רן א on 03/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct TaskSchedule: Identifiable {
    
    var id : UUID
    var taskName : String
    var startTime : Date
    var endTime : Date
    var day : dayOfTheWeek
    var date : Date
}


enum dayOfTheWeek:String {
    
  case Sunday
  case Monday
  case Tuesday
  case Wensday
  case Thursday
  case Friday
  case Saturday
    
}
