//
//  WeeklyRegular.swift
//  ManageMyTime
//
//  Created by רן א on 28/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI



struct WeeklyRegular: View {
    
    var timeChar : String
    var hourTasks : TasksPerHourPerDay
    var geometryWidth:CGFloat
    var geometryHeight:CGFloat
    
    var body: some View {
        HStack{
            WeeklyTasksPotrait(timeChar:String(timeChar),hourTasks: hourTasks).frame(width: geometryWidth/10.3, height:  geometryHeight/13).padding(EdgeInsets(top: 2, leading: 1, bottom: 1, trailing: 1))
 
                    Divider().foregroundColor(Color.red).padding(EdgeInsets(top: 2, leading: 5, bottom: 1, trailing: 1))
        }
    }
}

/*struct WeeklyRegular_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyRegular()
    }
}*/
