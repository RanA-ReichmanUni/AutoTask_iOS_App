//
//  TasksByHour.swift
//  ManageMyTime
//
//  Created by רן א on 14/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct TasksByHour:Identifiable{
    
    var id:UUID
    var hour : Int
    var tasks : [String]
    var offSet : Int

    
    init(offSet:Int,hour:Int,tasks:[String])
    {
        id=UUID()
        self.hour=hour
        self.tasks=tasks
        self.offSet=offSet

    }
 
}
