//
//  ScheduleViewRow.swift
//  ManageMyTime
//
//  Created by רן א on 01/07/2020.
//  Copyright © 2020 IMPACT. All rights reserved.
//

import SwiftUI

struct ScheduleViewRow: View {
    
    
    var timeChar = "25"
    //var columns : [String]
    
    var taskViewModel = TaskViewModel()
    var dayRange = 7...24
    
    var body: some View {
        
        GeometryReader { geometry in
            
        
       VStack{
        
                WeeklyScheduleBar()
        //Create special object for the view to achieve low coupling from the model, don't send task as is.
        
       
        
            List(self.dayRange,id:\.self){
                    hour in
                
                    Text(String(hour)).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 20))
                
                ForEach(self.taskViewModel.retrieveAllTasksByHour(hour:hour))
                    {
                        weekByHour in
                    
                        HStack {
                           /* if(self.taskViewModel.retrieveAllTasksByHour(hour:hour).count > 4)
                            {
                            Text(String(self.taskViewModel.retrieveAllTasksByHour(hour:hour)[4].isEmptySlot))
                            }*/
                            
                        
                            
                            WeeklyTasksRow(timeChar:String(hour),hourTasks: weekByHour)
                        }
                        
                    }
                
                
                        /*Text(self.timeChar).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 10))
                        
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-5, trailing: 0))
                        
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                        TestTaskRow(heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))*/
                    }
             /*   HStack{
                     Text(self.timeChar).padding(EdgeInsets(top: 5, leading: 0, bottom:0, trailing: 10))
                
                    TestTaskRow(taskName: "Algebra 1",heightFactor: CGFloat(0.7)).padding(EdgeInsets(top:-8, leading: 0, bottom:0, trailing: 0))
                    
                    TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                                         TestTaskRow(taskName:"Algebra 1",heightFactor: CGFloat(1.5)).padding(EdgeInsets(top: 6, leading: 0, bottom:-2, trailing: 0))
                }*/
        
            
            }
        }
    }
}

/*struct ScheduleViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleViewRow(timeChar:"23",columns: ["hello","what's up","infi b","algebra b","bla bla bla","sadfafas","fdsgfdsg"])/*.previewLayout(.fixed(width: 600, height: 300 ))*/
    }
}*/

