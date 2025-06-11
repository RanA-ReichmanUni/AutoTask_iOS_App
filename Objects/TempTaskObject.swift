//
//  TempTaskObject.swift
//  ManageMyTime
//
//  Created by רן א on 19/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
struct TempTaskObject {
    
        var active: Bool
        var color: String
        var completed: Bool
        var dueDate: Date
        var id: UUID
        var importance: String
        var isTaskBreakWindow: Bool
        var notes: String
        var taskName: String
        var internalId: UUID
        var asstimatedWorkTime: Hour
        var date: CustomDate
        var endTime: Hour
        var startTime: Hour
        var scheduleSection: String
        var associatedFreeSpaceId: UUID
        var difficulty: String



    init(active: Bool,color: String,completed: Bool,dueDate: Date,id: UUID,importance: String,isTaskBreakWindow: Bool,notes: String,taskName: String,internalId: UUID,asstimatedWorkTime: Hour,date: CustomDate,endTime: Hour,startTime: Hour,scheduleSection: String,associatedFreeSpaceId: UUID,difficulty: String)
    {
      
        self.taskName=taskName
        self.importance=importance
        self.dueDate=dueDate
        self.notes=notes
        self.asstimatedWorkTime=asstimatedWorkTime
        self.color=color
        self.difficulty=difficulty
        self.internalId=internalId
        self.id=id
        self.active=active
        self.isTaskBreakWindow=isTaskBreakWindow
        self.date=date
        self.endTime=endTime
        self.startTime=startTime
        self.scheduleSection=scheduleSection
        self.associatedFreeSpaceId=associatedFreeSpaceId
        self.completed=completed
        
    }

}
