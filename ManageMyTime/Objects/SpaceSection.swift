//
//  SpaceSection.swift
//  ManageMyTime
//
//  Created by רן א on 07/09/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import Foundation

struct SpaceSection:Identifiable{
    
    var id:UUID
    var breakTime : Hour?
    var sectionWindow:Hour?
    var isContinues:Bool
    
    init(breakTime:Hour?=nil,sectionWindow:Hour?=nil,isContinues:Bool=false)
    {
        id=UUID()
        self.breakTime=breakTime
        self.sectionWindow=sectionWindow
        self.isContinues=isContinues

    }
 
}
