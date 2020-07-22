//
//  FreeDayRepresentation.swift
//  ManageMyTime
//
//  Created by רן א on 08/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation


struct AvailableDay {
    
    var freeSpaceObj : FreeTaskSpace
    var day : Int
    
    
    init(freeSpaceObj : FreeTaskSpace, day : Int)
    {
        
        self.freeSpaceObj=freeSpaceObj
        self.day=day
        
        
    }
    
}
