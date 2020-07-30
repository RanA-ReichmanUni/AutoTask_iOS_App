//
//  LowRes750.swift
//  ManageMyTime
//
//  Created by רן א on 30/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct LowRes750Compact: View {
   var timeChar : String
   var hourTasks : TasksPerHourPerDay
   
   var geometry:GeometryProxy
 
   
   var body: some View {
       
       HStack{

        WeeklyTasksRow(timeChar:String(self.timeChar),hourTasks: self.hourTasks).frame(width: geometry.size.width/14.9, height:  geometry.size.height/15)
                                   
                       Divider().foregroundColor(Color.red).padding(EdgeInsets(top: 2, leading: 5, bottom: 1, trailing: 1))
           
       }
   }
}

/*struct LowRes750_Previews: PreviewProvider {
    static var previews: some View {
        LowRes750()
    }
}*/
