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
    @State var blurEffect:CGFloat = 0
     @ObservedObject var taskViewModel = TaskViewModel()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        HStack(spacing:4){
 
       
            WeeklyTasksRow(timeChar:String(self.timeChar),hourTasks: self.hourTasks, taskViewModel: taskViewModel).frame(width: geometry.size.width/widthFactor, height:  geometry.size.height/heightFactor)
            
            
            Divider().background(self.colorScheme == .dark ? Color.orange : Color.gray.opacity(0.1))
            //.padding(EdgeInsets(top: 2, leading: 5, bottom: 1, trailing: 1))
            
        }
    }
}

/*struct WeeklyCompact_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCompact()
    }
}
*/
