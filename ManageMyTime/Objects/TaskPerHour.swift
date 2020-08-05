//
//  TaskPerDay.swift
//  ManageMyTime
//
//  Created by רן א on 15/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct TaskPerHour:Identifiable{
    
    var id:UUID
    var taskName : String
    var taskId:UUID?
    var heightFactor:CGFloat
    var color : Color
    
    init(heightFactor:CGFloat,taskName:String,color:Color)
    {
        id=UUID()
        self.taskName=taskName
        self.heightFactor=heightFactor
        self.color=color
        
    }
 
}
