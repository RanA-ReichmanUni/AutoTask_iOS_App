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
    
    var geometryWidth:CGFloat
    var geometryHeight:CGFloat
    
    var body: some View {
        
        HStack{
 
                WeeklyTasksRow(timeChar:String(self.timeChar),hourTasks: self.hourTasks).frame(width: geometryWidth/14.3, height:  geometryHeight/15)
                                    
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
