//
//  ScehduleSelector.swift
//  ManageMyTime
//
//  Created by רן א on 28/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI


struct ScehduleSelector: View {
    
    var hour:String
    var weekByHour:TasksPerHourPerDay
    
    var geometryWidth:CGFloat
    var geometryHeight:CGFloat
    
      @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    
    var body: some View {
         VStack {
            
         if self.horizontalSizeClass == .compact {
                              
            WeeklyCompact(timeChar:String(hour),hourTasks: weekByHour,geometryWidth:self.geometryWidth,geometryHeight:self.geometryHeight)

                                             
            } else if self.horizontalSizeClass == .regular{
                     
                WeeklyRegular(timeChar:String(hour),hourTasks: weekByHour,geometryWidth:self.geometryWidth,geometryHeight:self.geometryHeight)
                    
            }
        }
       
    }
}

/*struct ScehduleSelector_Previews: PreviewProvider {
    static var previews: some View {
        ScehduleSelector()
    }
}
*/
