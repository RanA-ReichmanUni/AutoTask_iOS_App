//
//  Task.swift
//  ManageMyTime
//
//  Created by רן א on 21/06/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

enum TaskPriority {
    
  case high
  case medium
  case low
    
}

struct Task: Identifiable {//Commiting for the idnetifiable interface which requires us to create an 'id' field.
    
  var id: String = UUID().uuidString
  var title: String
  var completed: Bool
  var priority: TaskPriority
}
