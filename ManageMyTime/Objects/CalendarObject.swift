//
//  CalendarObject.swift
//  ManageMyTime
//
//  Created by רן א on 12/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import SwiftUI

struct CalendarObject {
    
   
    var taskName : String
    var color : String
    var startTime:Hour
    var endTime:Hour
    var isRepeatedActivity:Bool?
    var id:UUID
    
    
    init(id:UUID,taskName : String, color : String,startTime:Hour,endTime:Hour)
    {

        self.taskName=taskName
        self.color=color
        self.startTime=startTime
        self.endTime=endTime
        self.id=id
        
    }
    
}
