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
    
    var body: some View {
        
        GeometryReader { geometry in
            
        
       VStack{
        
                WeeklyScheduleBar()
        //Create special object for the view to achieve low coupling from the model, don't send task as is.
            List(self.taskViewModel.retrieveAllTasksByHour()){
            tasksOfHour in

               
                 
                WeeklyTasksRow(timeChar:String(tasksOfHour.hour),hourTasks: tasksOfHour.tasks, heightFactor: CGFloat(1.5),offSet:tasksOfHour.offSet)
                            
                        
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

