//
//  TaskPerDay.swift
//  ManageMyTime
//
//  Created by רן א on 15/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import UIKit

struct TaskPerHour:Identifiable{
    
    var id:UUID
    var taskName : String
    var heightFactor:CGFloat

    
    init(heightFactor:CGFloat,taskName:String)
    {
        id=UUID()
        self.taskName=taskName
        self.heightFactor=heightFactor

    }
 
}
