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
    var isRepeatedActivity:Bool?
    var taskName : String
    var taskId:UUID?
    var heightFactor:CGFloat
    var color : Color
    var opacity : CGFloat
 //   var startTime:Hour
    //var endTime:Hour
    
    init(heightFactor:CGFloat,taskName:String,color:Color,opacity:CGFloat/*,startTime:Hour,endTime:Hour*/)
    {
        id=UUID()
        self.taskName=taskName
        self.heightFactor=heightFactor
        self.color=color
        self.opacity=opacity
      /*  self.startTime=startTime
        self.endTime=endTime*/
    }
 
}
