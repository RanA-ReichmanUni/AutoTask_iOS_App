//
//  FreeSpaceRank.swift
//  ManageMyTime
//
//  Created by רן א on 26/10/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct FreeSpaceRank {
    
   
    var freeSpace : FreeTaskSpace
    var rank:Double
    
    
    init(freeSpace:FreeTaskSpace,rank:Double)
    {

        self.freeSpace=freeSpace
        self.rank=rank
      
    }
    
}
