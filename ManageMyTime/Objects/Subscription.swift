//
//  Subscription.swift
//  ManageMyTime
//
//  Created by רן א on 04/11/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct Subscription {
    
   
    var title:String
    var price:String
    var duration:String
    var id:UUID
    
    init(title:String,price:String,duration:String)
    {
        self.id=UUID()
        self.title=title
        self.price=price
        self.duration=duration
      
    }
    
}
