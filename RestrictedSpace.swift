//
//  RestrictedSpace.swift
//  ManageMyTime
//
//  Created by רן א on 06/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct RestrictedSpace1: Identifiable {
    
    var id : UUID
    var startTime : Date
    var endTime : Date
    var dayOfTheWeek : dayOfTheWeek

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
