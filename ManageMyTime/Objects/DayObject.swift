//
//  DayObject.swift
//  ManageMyTime
//
//  Created by רן א on 04/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct DayObject: Identifiable {
    
    var id : UUID
    var hours : [HourlyTask]
    var date : Date
    var day : dayOfTheWeek
    
}

