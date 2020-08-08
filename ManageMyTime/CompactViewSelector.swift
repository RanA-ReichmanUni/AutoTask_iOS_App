//
//  CompactViewSelector.swift
//  ManageMyTime
//
//  Created by רן א on 30/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct CompactViewSelector: View {
    
    var hour:String
    var weekByHour:TasksPerHourPerDay
    
    var geometry:GeometryProxy

    
      @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
         HStack(spacing:0) {
                   
          
                  
            if(geometry.size.width <= 414 && geometry.size.width > 375)//IPhone 11,IPhone 8
             {
                                  
                WeeklyCompact(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:11,heightFactor:10)//.scaledToFill()
                                                                
             }
                         
             else if(geometry.size.width <= 667 && geometry.size.width > 375 )//iphone 6s,8,7,SE.. on the side
             {
                WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:12.1,heightFactor:8)
             }
           else {//iphone 6s,8,7,SE
                WeeklyCompact(timeChar:String(hour),hourTasks: weekByHour,geometry:self.geometry,widthFactor:12,heightFactor:9)
            }

        }
    }
}
/*
struct CompactViewSelector_Previews: PreviewProvider {
    static var previews: some View {
        CompactViewSelector()
    }
}*/
