//
//  WorkPerDate.swift
//  ManageMyTime
//
//  Created by רן א on 15/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct WorkPerDate:Identifiable{

    
    var id:UUID
    var date : CustomDate?
    var timeInMinutes:Int?

    
    init(date:CustomDate?=nil,timeInMinutes:Int?=nil)
    {
        id=UUID()
        self.date=date
        self.timeInMinutes=timeInMinutes

    }
 
}
