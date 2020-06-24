//
//  Task.swift
//  ManageMyTime
//
//  Created by רן א on 21/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

enum TaskImportance {
    
  case veryHigh
  case high
  case medium
  case low
  case veryLow
    
}

struct Task: Identifiable {//Commiting for the idnetifiable interface which requires us to create an 'id' field.
    
  var id: String = UUID().uuidString
  var taskName: String
  var active: Bool
  var completed: Bool
  var importance: TaskImportance
  var notes : String
  var dueDate : Date
  var asstimatedWorkTime : Date
    
}
