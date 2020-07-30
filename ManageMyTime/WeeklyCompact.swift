//
//  WeeklyCompact.swift
//  ManageMyTime
//
//  Created by רן א on 28/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct WeeklyCompact: View {
    var timeChar : String
    var hourTasks : TasksPerHourPerDay
    
    var geometry:GeometryProxy
    var widthFactor:CGFloat
    var heightFactor:CGFloat
    
    var body: some View {
        
        HStack{
 
            WeeklyTasksRow(timeChar:String(self.timeChar),hourTasks: self.hourTasks).frame(width: geometry.size.width/widthFactor, height:  geometry.size.height/heightFactor)
                                    
                        Divider().foregroundColor(Color.red).padding(EdgeInsets(top: 2, leading: 5, bottom: 1, trailing: 1))
            
        }
    }
}

/*struct WeeklyCompact_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCompact()
    }
}
*/
