//
//  PriorityPerDate.swift
//  ManageMyTime
//
//  Created by רן א on 17/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct PriorityPerDate:Identifiable{

    
    var id:UUID
    var date : CustomDate?
    var rank:Double?

    
    init(date:CustomDate?=nil,rank:Double?=nil)
    {
        id=UUID()
        self.date=date
        self.rank=rank

    }
 
}
